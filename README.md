# MongoDB Gemini CLI Extension

A Gemini CLI extension that provides MongoDB database and Atlas operations through the [Model Context Protocol (MCP)](https://modelcontextprotocol.io/).

This extension wraps the official [`mongodb-mcp-server`](https://github.com/mongodb-js/mongodb-mcp-server) npm package, providing seamless installation for Gemini CLI users with automatic upstream updates.

## Installation

### Deploy script (recommended)

```bash
git clone https://github.com/mohammaddaoudfarooqi/mongodb-gemini-extension.git
cd mongodb-gemini-extension
./deploy-mongodb-gemini-extension.sh
```

The script checks prerequisites, installs the extension to `~/.gemini/extensions/mongodb/`, and prompts for your MongoDB connection string.

Pass the URI directly for non-interactive use:

```bash
./deploy-mongodb-gemini-extension.sh --uri "mongodb+srv://user:pass@cluster.mongodb.net/mydb"
```

### Install from GitHub

```bash
gemini extensions install https://github.com/mongodb-partners/mongodb-gemini-extension.git
```

### Manual installation

```bash
git clone https://github.com/mohammaddaoudfarooqi/mongodb-gemini-extension.git
cd mongodb-gemini-extension
npm install
mkdir -p ~/.gemini/extensions
cp -R . ~/.gemini/extensions/mongodb
```

## Quick start

1. Copy the configuration template:

   ```bash
   cd ~/.gemini/extensions/mongodb
   cp mongo.config.json.example mongo.config.json
   ```

2. Add your MongoDB connection string to `mongo.config.json`:

   ```json
   {
     "MONGODB_URI": "mongodb+srv://user:pass@cluster.mongodb.net/mydb"
   }
   ```

3. Restart the Gemini CLI and verify:

   ```
   /mcp
   /tools
   ```

   The MongoDB server and its tools appear in the output.

> **Security:** `mongo.config.json` contains credentials and is excluded from version control via `.gitignore`. Do not commit this file.

## Features

- **MongoDB CRUD** — find, aggregate, insert, update, delete operations on collections
- **Schema and index management** — create/drop indexes, infer collection schemas, view stats
- **Atlas cluster management** — list orgs/projects, create clusters, manage users and access lists
- **Atlas Search** — create and list Atlas Search indexes
- **Local deployments** — create local Atlas deployments via Docker
- **Data export** — export query results to EJSON
- **Read-only mode** — restrict the extension to read operations
- **Automatic updates** — weekly CI checks for new `mongodb-mcp-server` releases

## Tools

All tools come from the upstream [MongoDB MCP Server](https://github.com/mongodb-js/mongodb-mcp-server). The available set depends on the installed version.

### Database tools

| Tool | Description |
|------|-------------|
| `find` | Run a find query against a collection |
| `aggregate` | Run an aggregation pipeline |
| `count` | Count documents in a collection |
| `insert-one` | Insert a single document |
| `insert-many` | Insert multiple documents |
| `update-one` | Update a single document |
| `update-many` | Update multiple documents |
| `delete-one` | Delete a single document |
| `delete-many` | Delete multiple documents |
| `create-index` | Create an index on a collection |
| `drop-index` | Drop an index from a collection |
| `rename-collection` | Rename a collection |
| `drop-collection` | Drop a collection |
| `drop-database` | Drop a database |
| `list-databases` | List all databases |
| `list-collections` | List collections in a database |
| `collection-indexes` | List indexes on a collection |
| `collection-schema` | Infer the schema of a collection |
| `collection-storage-size` | Get collection size in MB |
| `db-stats` | Get database statistics |
| `export` | Export query results to EJSON |
| `explain` | Explain a query execution plan |

### Atlas tools

Requires `MDB_MCP_API_CLIENT_ID` and `MDB_MCP_API_CLIENT_SECRET` in your configuration. See the [configuration reference](docs/configuration.md).

| Tool | Description |
|------|-------------|
| `atlas-list-orgs` | List Atlas organizations |
| `atlas-list-projects` | List Atlas projects |
| `atlas-create-project` | Create an Atlas project |
| `atlas-list-clusters` | List Atlas clusters |
| `atlas-inspect-cluster` | Inspect a specific cluster |
| `atlas-create-free-cluster` | Create a free-tier cluster |
| `atlas-connect-cluster` | Connect to an Atlas cluster |
| `atlas-inspect-access-list` | Inspect IP/CIDR access list |
| `atlas-create-access-list` | Add IP/CIDR to access list |
| `atlas-list-db-users` | List database users |
| `atlas-create-db-user` | Create a database user |
| `atlas-list-alerts` | List project alerts |

### Local deployment tools

| Tool | Description |
|------|-------------|
| `atlas-local-create-deployment` | Create a local Atlas deployment via Docker |

### Search index tools

| Tool | Description |
|------|-------------|
| `create-search-index` | Create an Atlas Search index |
| `list-search-indexes` | List search indexes on a collection |

Run `/tools` in Gemini CLI to see the tools available with your installed version.

## Resources

| Resource | Description |
|----------|-------------|
| `config` | Server configuration (sensitive values redacted) |
| `debug` | Debugging info for connectivity issues |
| `exported-data` | Data exported via the `export` tool |

## Updating

### Automatic

A GitHub Actions workflow (`.github/workflows/sync-upstream.yml`) runs weekly. When a new `mongodb-mcp-server` version is published, it creates a pull request with the updated dependency.

### Manual

```bash
cd ~/.gemini/extensions/mongodb
npm install mongodb-mcp-server@latest
```

Check the installed version:

```bash
npm list mongodb-mcp-server
```

Restart the Gemini CLI after updating.

## Documentation

- [Configuration reference](docs/configuration.md) — all config options and examples
- [Architecture](docs/architecture.md) — how the extension works and why
- [Developer guide](docs/developer-guide.md) — setup, testing, and contributing
- [Troubleshooting](docs/troubleshooting.md) — common errors and fixes

## License

Apache-2.0 — see [LICENSE](LICENSE).

## Links

- [MongoDB MCP Server (upstream)](https://github.com/mongodb-js/mongodb-mcp-server)
- [MongoDB MCP Server on npm](https://www.npmjs.com/package/mongodb-mcp-server)
- [Gemini CLI](https://github.com/google-gemini/gemini-cli)
- [MongoDB documentation](https://docs.mongodb.com/)
- [MongoDB Atlas](https://www.mongodb.com/atlas)
- [Model Context Protocol](https://modelcontextprotocol.io/)
