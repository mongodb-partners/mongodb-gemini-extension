# Architecture

## Overview

The MongoDB Gemini CLI Extension connects Gemini CLI to MongoDB databases and Atlas services through the [Model Context Protocol (MCP)](https://modelcontextprotocol.io/). It is a thin wrapper around the official [`mongodb-mcp-server`](https://github.com/mongodb-js/mongodb-mcp-server) npm package.

## Design decision: dependency, not fork

This extension declares `mongodb-mcp-server` as an npm dependency rather than vendoring its source code. The entry point (`run.js`) handles configuration and startup. All MongoDB functionality comes from the upstream package.

**Context:** The upstream `mongodb-mcp-server` repository contains 200+ files of TypeScript source, build tooling, and infrastructure. Forking it would require ongoing effort to merge upstream changes, resolve conflicts, and maintain build tooling.

**Trade-offs:**

| Benefit | Cost |
|---------|------|
| Upstream improvements arrive via `npm install` | No control over upstream API changes |
| No source code to merge or rebase | Must stay compatible with `StdioRunner` and `parseUserConfig` exports |
| A handful of extension files instead of 200+ | Upstream breaking changes require adaptation |

## Components

```
┌──────────────────────────────────────────────────┐
│  Gemini CLI                                      │
│                                                  │
│  Reads gemini-extension.json                     │
│  Launches: node run.js                           │
│  Communicates via stdio                          │
└──────────────┬───────────────────────────────────┘
               │ stdio (MCP protocol)
               ▼
┌──────────────────────────────────────────────────┐
│  run.js (entry point)                            │
│                                                  │
│  1. Reads mongo.config.json                      │
│  2. Maps config keys → MDB_MCP_* env vars        │
│  3. Imports mongodb-mcp-server                   │
│  4. Calls parseUserConfig() to build UserConfig  │
│  5. Creates StdioRunner and starts the server    │
└──────────────┬───────────────────────────────────┘
               │
               ▼
┌──────────────────────────────────────────────────┐
│  mongodb-mcp-server (npm dependency)             │
│                                                  │
│  MCP server with all MongoDB/Atlas tools         │
│  Connects to MongoDB via connection string       │
│  Connects to Atlas via API credentials           │
└──────────────────────────────────────────────────┘
```

## Data flow

1. **Gemini CLI** reads `gemini-extension.json` and invokes `node run.js`.
2. **`run.js`** reads `mongo.config.json` from its own directory.
3. **`run.js`** maps each config key to the corresponding `MDB_MCP_*` environment variable using the `CONFIG_TO_ENV` object.
4. **`run.js`** dynamically imports `mongodb-mcp-server` and calls `parseUserConfig()`, which reads the environment variables and CLI arguments to produce a `UserConfig` object.
5. **`run.js`** creates a `StdioRunner` instance with the `UserConfig` and calls `runner.start()`.
6. **`StdioRunner`** sets up the MCP server with all tools, resources, and stdio transport.
7. **Gemini CLI** sends MCP requests over stdin. The server processes them and returns responses over stdout.

## File responsibilities

| File | Responsibility |
|------|----------------|
| `gemini-extension.json` | Declares the extension to Gemini CLI: name, version, MCP server command |
| `run.js` | Entry point: config loading, env var mapping, server startup |
| `mongo.config.json` | User configuration (credentials, options). Not tracked in git. |
| `mongo.config.json.example` | Configuration template with all available keys |
| `package.json` | Declares `mongodb-mcp-server` as a dependency, defines scripts |
| `deploy-mongodb-gemini-extension.sh` | Automated installation: prerequisite checks, backup, file copy, npm install, config setup |

## Extension manifest

`gemini-extension.json` tells Gemini CLI how to start the MCP server:

```json
{
  "name": "mongodb",
  "version": "2.0.0",
  "mcpServers": {
    "mongodb": {
      "command": "node",
      "args": ["${extensionPath}/run.js"],
      "trust": true
    }
  }
}
```

`${extensionPath}` is resolved by Gemini CLI to the extension's installation directory.

## Upstream synchronization

The GitHub Actions workflow `.github/workflows/sync-upstream.yml` runs weekly:

1. Queries the npm registry for the latest `mongodb-mcp-server` version.
2. Compares it to the version in `package.json`.
3. If a newer version exists, runs `npm install mongodb-mcp-server@latest`.
4. Runs the test suite to verify compatibility.
5. Creates a pull request with the updated dependency.

This keeps the extension current without manual intervention.
