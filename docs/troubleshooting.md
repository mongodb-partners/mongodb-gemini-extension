# Troubleshooting

## "Configuration file not found" error

The extension cannot find `mongo.config.json` in its directory.

Create the config file:

```bash
cd ~/.gemini/extensions/mongodb
cp mongo.config.json.example mongo.config.json
```

Edit `mongo.config.json` and add your MongoDB connection string.

## "MONGODB_URI not found" error

The config file exists but does not contain a connection string.

Add `MONGODB_URI` to `mongo.config.json`:

```json
{
  "MONGODB_URI": "mongodb+srv://user:pass@cluster.mongodb.net/mydb"
}
```

Either `MONGODB_URI` or `MDB_MCP_CONNECTION_STRING` is accepted.

## "Failed to parse mongo.config.json" error

The config file contains invalid JSON.

Validate the file contents. Common issues:

- Trailing commas after the last key-value pair
- Missing quotes around keys or values
- Comments (JSON does not support comments)

A valid configuration file:

```json
{
  "MONGODB_URI": "mongodb+srv://user:pass@cluster.mongodb.net/mydb"
}
```

## Extension not listed in Gemini CLI

1. Verify the extension is installed:

   ```bash
   ls ~/.gemini/extensions/mongodb/gemini-extension.json
   ```

2. If `gemini-extension.json` is missing, reinstall the extension. See the [README](../README.md#installation).

3. If `node_modules/` is missing, install dependencies:

   ```bash
   cd ~/.gemini/extensions/mongodb
   npm install
   ```

4. Restart the Gemini CLI.

## Tools not responding

1. Verify the MongoDB connection string is correct and the database is reachable.

2. For Atlas tools (`atlas-*`), confirm that `MDB_MCP_API_CLIENT_ID` and `MDB_MCP_API_CLIENT_SECRET` are set in `mongo.config.json`. See the [configuration reference](configuration.md).

3. Check `/mcp` in Gemini CLI for server status.

4. Enable logging to inspect server output:

   ```json
   {
     "MONGODB_URI": "mongodb+srv://user:pass@cluster.mongodb.net/mydb",
     "MDB_MCP_LOG_PATH": "/tmp/mongodb-mcp.log"
   }
   ```

   Then check `/tmp/mongodb-mcp.log` for errors.

## "Failed to start MongoDB MCP Server" error

The `mongodb-mcp-server` package failed to initialize. Possible causes:

- **Dependency not installed:** Run `npm install` in the extension directory.
- **Node.js version too old:** The extension requires Node.js v20.19.0+, v22.12.0+, or v23+. Check with `node -v`.
- **Corrupted installation:** Remove `node_modules/` and reinstall:

  ```bash
  cd ~/.gemini/extensions/mongodb
  rm -rf node_modules
  npm install
  ```

## Updating fails or breaks the extension

If `npm install mongodb-mcp-server@latest` causes issues:

1. Check the [upstream releases](https://github.com/mongodb-js/mongodb-mcp-server/releases) for breaking changes.

2. Pin to the last working version:

   ```bash
   cd ~/.gemini/extensions/mongodb
   npm install mongodb-mcp-server@1.8.0
   ```

3. Report the issue on the [extension's GitHub repository](https://github.com/mohammaddaoudfarooqi/mongodb-gemini-extension/issues).
