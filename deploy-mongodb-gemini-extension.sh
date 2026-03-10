#!/usr/bin/env bash
#
# deploy-mongodb-gemini-extension.sh
#
# Automated deployment script for the MongoDB Gemini CLI Extension.
# Replaces the manual 8-step installation with a single command.
#
# Usage:
#   ./deploy-mongodb-gemini-extension.sh [--uri <connection-string>] [--help]
#
# Environment variables:
#   MONGODB_URI   - MongoDB connection string (used if --uri not provided)
#
# Requirements:
#   - Node.js >= 20.19.0
#   - npm
#   - git
#

set -e

# ============================================================================
# Constants
# ============================================================================

GITHUB_REPO="https://github.com/mohammaddaoudfarooqi/mongodb-gemini-extension.git"
EXTENSIONS_DIR="$HOME/.gemini/extensions"
TARGET_DIR="$HOME/.gemini/extensions/mongodb"
MIN_NODE_MAJOR=20
MIN_NODE_MINOR=19
MIN_NODE_PATCH=0
SCRIPT_NAME="$(basename "$0")"
BACKUP_DIR=""

# Files to copy when installing from a local repo
INSTALL_FILES="run.js package.json package-lock.json gemini-extension.json mongo.config.json.example README.md LICENSE"

# ============================================================================
# Color output (if terminal supports it)
# ============================================================================

if [ -t 1 ]; then
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  YELLOW='\033[0;33m'
  BLUE='\033[0;34m'
  NC='\033[0m'  # No Color
else
  RED=''
  GREEN=''
  YELLOW=''
  BLUE=''
  NC=''
fi

# ============================================================================
# Helper functions
# ============================================================================

info() {
  printf "${BLUE}[INFO]${NC} %s\n" "$1"
}

success() {
  printf "${GREEN}[OK]${NC}   %s\n" "$1"
}

warn() {
  printf "${YELLOW}[WARN]${NC} %s\n" "$1" >&2
}

error() {
  printf "${RED}[ERROR]${NC} %s\n" "$1" >&2
}

die() {
  error "$1"
  exit 1
}

usage() {
  cat <<EOF
Usage: $SCRIPT_NAME [OPTIONS]

Deploy the MongoDB Gemini CLI Extension to ~/.gemini/extensions/mongodb

Options:
  --uri <string>   MongoDB connection string (e.g., mongodb+srv://user:pass@host/db)
  --help           Show this help message and exit

Environment Variables:
  MONGODB_URI      MongoDB connection string (used if --uri is not provided)

Examples:
  # Interactive — prompts for connection string
  ./$SCRIPT_NAME

  # Non-interactive — pass URI directly
  ./$SCRIPT_NAME --uri "mongodb+srv://user:pass@cluster.mongodb.net/mydb"

  # Non-interactive — use environment variable
  MONGODB_URI="mongodb+srv://user:pass@cluster.mongodb.net/mydb" ./$SCRIPT_NAME

What this script does:
  1. Checks prerequisites (Node.js >= 20.19.0, npm, git)
  2. Creates ~/.gemini/extensions/ if it does not exist
  3. Backs up any existing mongodb extension (timestamped)
  4. Installs extension files (from local repo or git clone)
  5. Runs npm install (or npm ci if lock file present)
  6. Configures mongo.config.json (if not already present)
  7. Prints success summary with next steps
EOF
}

# ============================================================================
# Argument parsing
# ============================================================================

URI_ARG=""

while [ $# -gt 0 ]; do
  case "$1" in
    --uri)
      if [ -z "$2" ] || [ "${2#-}" != "$2" ]; then
        die "--uri requires a connection string argument"
      fi
      URI_ARG="$2"
      shift 2
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      die "Unknown option: $1. Use --help for usage."
      ;;
  esac
done

# ============================================================================
# Step 1: Check prerequisites
# ============================================================================

info "Checking prerequisites..."

# Check node
if ! command -v node >/dev/null 2>&1; then
  die "Node.js is not installed. Please install Node.js >= ${MIN_NODE_MAJOR}.${MIN_NODE_MINOR}.${MIN_NODE_PATCH} from https://nodejs.org/"
fi

# Verify Node.js version >= 20.19.0
NODE_VERSION="$(node --version | sed 's/^v//')"
NODE_MAJOR="$(echo "$NODE_VERSION" | cut -d. -f1)"
NODE_MINOR="$(echo "$NODE_VERSION" | cut -d. -f2)"
NODE_PATCH="$(echo "$NODE_VERSION" | cut -d. -f3)"

version_ok=false
if [ "$NODE_MAJOR" -gt "$MIN_NODE_MAJOR" ] 2>/dev/null; then
  version_ok=true
elif [ "$NODE_MAJOR" -eq "$MIN_NODE_MAJOR" ] 2>/dev/null; then
  if [ "$NODE_MINOR" -gt "$MIN_NODE_MINOR" ] 2>/dev/null; then
    version_ok=true
  elif [ "$NODE_MINOR" -eq "$MIN_NODE_MINOR" ] 2>/dev/null; then
    if [ "$NODE_PATCH" -ge "$MIN_NODE_PATCH" ] 2>/dev/null; then
      version_ok=true
    fi
  fi
fi

if [ "$version_ok" != "true" ]; then
  die "Node.js version $NODE_VERSION is too old. Required: >= ${MIN_NODE_MAJOR}.${MIN_NODE_MINOR}.${MIN_NODE_PATCH}"
fi
success "Node.js $NODE_VERSION"

# Check npm
if ! command -v npm >/dev/null 2>&1; then
  die "npm is not installed. Please install npm (usually bundled with Node.js)."
fi
NPM_VERSION="$(npm --version)"
success "npm $NPM_VERSION"

# Check git
if ! command -v git >/dev/null 2>&1; then
  die "git is not installed. Please install git from https://git-scm.com/"
fi
GIT_VERSION="$(git --version | sed 's/git version //')"
success "git $GIT_VERSION"

# ============================================================================
# Step 2: Detect / create extensions directory
# ============================================================================

info "Setting up Gemini extensions directory..."

if [ ! -d "$EXTENSIONS_DIR" ]; then
  mkdir -p "$EXTENSIONS_DIR" || die "Cannot create $EXTENSIONS_DIR — check permissions."
  success "Created $EXTENSIONS_DIR"
else
  success "Extensions directory exists: $EXTENSIONS_DIR"
fi

# ============================================================================
# Step 3: Backup existing extension (if any)
# ============================================================================

if [ -d "$TARGET_DIR" ]; then
  BACKUP_SUFFIX="$(date +%Y%m%d-%H%M%S)"
  BACKUP_DIR="${TARGET_DIR}.backup.${BACKUP_SUFFIX}"
  info "Backing up existing extension to $(basename "$BACKUP_DIR")..."
  mv "$TARGET_DIR" "$BACKUP_DIR" || die "Failed to backup existing extension."
  success "Backup created: $BACKUP_DIR"
fi

# ============================================================================
# Step 4: Install extension files
# ============================================================================

info "Installing extension..."

# Detect if we're running from within the repo (local install)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
IS_LOCAL_REPO=false

if [ -f "$SCRIPT_DIR/run.js" ] && [ -f "$SCRIPT_DIR/package.json" ] && [ -f "$SCRIPT_DIR/gemini-extension.json" ]; then
  IS_LOCAL_REPO=true
fi

if [ "$IS_LOCAL_REPO" = "true" ]; then
  info "Installing from local repository: $SCRIPT_DIR"
  mkdir -p "$TARGET_DIR"

  # Copy essential files
  for f in $INSTALL_FILES; do
    if [ -f "$SCRIPT_DIR/$f" ]; then
      cp -R "$SCRIPT_DIR/$f" "$TARGET_DIR/" || die "Failed to copy $f"
    fi
  done

  success "Copied extension files from local repo"
else
  info "Cloning from GitHub: $GITHUB_REPO"
  git clone --depth 1 "$GITHUB_REPO" "$TARGET_DIR" || die "Failed to clone repository."
  success "Cloned extension from GitHub"
fi

# ============================================================================
# Step 5: Run npm install
# ============================================================================

info "Installing Node.js dependencies..."

cd "$TARGET_DIR" || die "Cannot cd to $TARGET_DIR"

if [ -f "package-lock.json" ]; then
  npm ci --no-audit --no-fund 2>&1 || die "npm ci failed. Check the output above for details."
  success "Dependencies installed (npm ci)"
else
  npm install --no-audit --no-fund 2>&1 || die "npm install failed. Check the output above for details."
  success "Dependencies installed (npm install)"
fi

# ============================================================================
# Step 6: Configure mongo.config.json
# ============================================================================

CONFIG_FILE="$TARGET_DIR/mongo.config.json"

if [ -f "$CONFIG_FILE" ]; then
  info "Existing mongo.config.json found — preserving your configuration."
  success "Configuration preserved"
elif [ -f "$BACKUP_DIR/mongo.config.json" ] 2>/dev/null; then
  info "Restoring mongo.config.json from backup..."
  cp "$BACKUP_DIR/mongo.config.json" "$CONFIG_FILE" || warn "Could not restore config from backup."
  success "Configuration restored from backup"
else
  # Determine the MongoDB URI: --uri flag > MONGODB_URI env var > interactive prompt
  MONGO_URI=""

  if [ -n "$URI_ARG" ]; then
    MONGO_URI="$URI_ARG"
    info "Using MongoDB URI from --uri argument"
  elif [ -n "$MONGODB_URI" ]; then
    MONGO_URI="$MONGODB_URI"
    info "Using MongoDB URI from MONGODB_URI environment variable"
  else
    # Interactive prompt
    printf "\n"
    printf "${BLUE}Enter your MongoDB connection string${NC}\n"
    printf "(e.g., mongodb+srv://user:pass@cluster.mongodb.net/mydb)\n"
    printf "Press Enter to skip and configure later.\n\n"
    printf "> "
    read -r MONGO_URI
  fi

  if [ -n "$MONGO_URI" ]; then
    cat > "$CONFIG_FILE" <<CONFIGEOF
{
  "MONGODB_URI": "$MONGO_URI"
}
CONFIGEOF
    success "Created mongo.config.json with your connection string"
  else
    info "Skipping configuration. To configure later:"
    info "  cd $TARGET_DIR"
    info "  cp mongo.config.json.example mongo.config.json"
    info "  # Edit mongo.config.json with your MongoDB connection string"
  fi
fi

# ============================================================================
# Step 7: Print success summary
# ============================================================================

printf "\n"
printf "${GREEN}========================================${NC}\n"
printf "${GREEN}  Deployment Complete!${NC}\n"
printf "${GREEN}========================================${NC}\n"
printf "\n"
printf "Extension installed to: ${BLUE}%s${NC}\n" "$TARGET_DIR"

if [ -f "$CONFIG_FILE" ]; then
  printf "Configuration:          ${GREEN}mongo.config.json configured${NC}\n"
else
  printf "Configuration:          ${YELLOW}Not yet configured${NC}\n"
fi

printf "\n"
printf "${BLUE}Next steps:${NC}\n"
printf "  1. Restart the Gemini CLI\n"
printf "  2. Run ${BLUE}/mcp${NC} to verify the MongoDB server is connected\n"
printf "  3. Run ${BLUE}/tools${NC} to see available MongoDB tools\n"

if [ ! -f "$CONFIG_FILE" ]; then
  printf "\n"
  printf "${YELLOW}Don't forget to configure your MongoDB connection:${NC}\n"
  printf "  cd %s\n" "$TARGET_DIR"
  printf "  cp mongo.config.json.example mongo.config.json\n"
  printf "  # Edit mongo.config.json with your connection string\n"
fi

printf "\n"
