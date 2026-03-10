# Developer Guide

## Prerequisites

- [Node.js](https://nodejs.org/) v20.19.0+, v22.12.0+, or v23+
- npm (bundled with Node.js)
- git

## Setup

```bash
git clone https://github.com/mohammaddaoudfarooqi/mongodb-gemini-extension.git
cd mongodb-gemini-extension
npm install
```

## Run tests

```bash
npm test
```

Run tests in watch mode during development:

```bash
npm run test:watch
```

## Project structure

```
mongodb-gemini-extension/
├── .github/workflows/
│   ├── ci.yml                           # Tests on push/PR (Node 20, 22)
│   └── sync-upstream.yml                # Weekly upstream version check
├── tests/
│   ├── config.test.js                   # Config loading and error handling
│   └── dependency.test.js               # mongodb-mcp-server API verification
├── docs/
│   ├── configuration.md                 # Configuration reference
│   ├── architecture.md                  # Architecture and design
│   ├── developer-guide.md               # This file
│   └── troubleshooting.md              # Error resolution
├── deploy-mongodb-gemini-extension.sh   # Automated deploy script
├── gemini-extension.json                # Gemini CLI extension manifest
├── run.js                               # Extension entry point
├── mongo.config.json.example            # Configuration template
├── vitest.config.js                     # Test runner configuration
├── package.json                         # npm package definition
├── .gitignore                           # Git ignore rules
├── README.md                            # Project overview
└── LICENSE                              # Apache-2.0
```

## Test suites

All tests use [Vitest](https://vitest.dev/) and run in Node.js. Tests do not require a running MongoDB instance.

| Test file | Tests | What it validates |
|-----------|-------|-------------------|
| `config.test.js` | 5 | Extension starts with valid config; config keys map to `MDB_MCP_*` env vars; errors on missing config, missing `MONGODB_URI`, and malformed JSON |
| `dependency.test.js` | 5 | `mongodb-mcp-server` is importable; exports `StdioRunner`, `Server`, `Session`, and configuration utilities |

## CI

GitHub Actions runs on every push to `main` and every pull request:

- **Matrix:** Node.js 20, 22
- **Steps:** `npm ci` -> `npm test` -> smoke test (starts extension with test URI, verifies it does not crash)

See `.github/workflows/ci.yml`.

## Add a new configuration key

When `mongodb-mcp-server` adds a new environment variable:

1. Add the mapping to the `CONFIG_TO_ENV` object in `run.js`:

   ```javascript
   const CONFIG_TO_ENV = {
     // ... existing mappings ...
     NEW_CONFIG_KEY: "MDB_MCP_NEW_FEATURE",
   };
   ```

2. Add the key to `mongo.config.json.example` with an empty string default.

3. Document the key in `docs/configuration.md`.

4. Run `npm test` to verify nothing breaks.

## Contributing

Most feature work belongs in the upstream [mongodb-mcp-server](https://github.com/mongodb-js/mongodb-mcp-server) repository. This extension accepts changes related to:

- Configuration handling
- Gemini CLI integration
- Deploy script improvements
- Documentation
- Test coverage

Workflow:

1. Fork this repository.
2. Create a feature branch.
3. Make changes.
4. Run tests: `npm test`
5. Submit a pull request.
