# Configuration Reference

All configuration is stored in `mongo.config.json`, located in the extension directory (`~/.gemini/extensions/mongodb/` after installation).

## Create the configuration file

```bash
cd ~/.gemini/extensions/mongodb
cp mongo.config.json.example mongo.config.json
```

Edit `mongo.config.json` with your credentials. At minimum, set `MONGODB_URI`:

```json
{
  "MONGODB_URI": "mongodb+srv://user:pass@cluster.mongodb.net/mydb?retryWrites=true&w=majority"
}
```

## Configuration options

Set a value to `""` (empty string) or omit the key to use the default.

| Key | Description | Default |
|-----|-------------|---------|
| `MONGODB_URI` | MongoDB connection string (**required**) | — |
| `MDB_MCP_READ_ONLY` | Set to `"true"` to prevent write operations | `"false"` |
| `MDB_MCP_INDEX_CHECK` | Set to `"true"` to require queries to use an index | `"false"` |
| `MDB_MCP_MAX_DOCUMENTS_PER_QUERY` | Maximum documents returned per query | `"10"` |
| `MDB_MCP_MAX_BYTES_PER_QUERY` | Maximum result size in bytes | `"16777216"` (16 MB) |
| `MDB_MCP_DISABLED_TOOLS` | Comma-separated list of tool names to disable | `""` |
| `MDB_MCP_API_CLIENT_ID` | Atlas API service account client ID | `""` |
| `MDB_MCP_API_CLIENT_SECRET` | Atlas API service account client secret | `""` |
| `MDB_MCP_LOG_PATH` | Path to write server logs | `""` |
| `MDB_MCP_VOYAGE_AI_API_KEY` | Voyage AI API key for vector search embeddings | `""` |

## How configuration maps to environment variables

The entry point `run.js` reads `mongo.config.json` and maps each key to the environment variable expected by `mongodb-mcp-server`:

| Config key | Environment variable |
|------------|---------------------|
| `MONGODB_URI` | `MDB_MCP_CONNECTION_STRING` |
| `MDB_MCP_CONNECTION_STRING` | `MDB_MCP_CONNECTION_STRING` |
| `MDB_MCP_READ_ONLY` | `MDB_MCP_READ_ONLY` |
| `MDB_MCP_INDEX_CHECK` | `MDB_MCP_INDEX_CHECK` |
| `MDB_MCP_MAX_DOCUMENTS_PER_QUERY` | `MDB_MCP_MAX_DOCUMENTS_PER_QUERY` |
| `MDB_MCP_MAX_BYTES_PER_QUERY` | `MDB_MCP_MAX_BYTES_PER_QUERY` |
| `MDB_MCP_DISABLED_TOOLS` | `MDB_MCP_DISABLED_TOOLS` |
| `MDB_MCP_API_CLIENT_ID` | `MDB_MCP_API_CLIENT_ID` |
| `MDB_MCP_API_CLIENT_SECRET` | `MDB_MCP_API_CLIENT_SECRET` |
| `MDB_MCP_LOG_PATH` | `MDB_MCP_LOG_PATH` |
| `MDB_MCP_VOYAGE_AI_API_KEY` | `MDB_MCP_VOYAGE_AI_API_KEY` |

`MONGODB_URI` is a convenience alias. Both `MONGODB_URI` and `MDB_MCP_CONNECTION_STRING` map to the same environment variable. Use either one.

## Examples

### Read-only mode

Prevent all write operations:

```json
{
  "MONGODB_URI": "mongodb+srv://user:pass@cluster.mongodb.net/mydb",
  "MDB_MCP_READ_ONLY": "true"
}
```

### Atlas management

Enable Atlas cluster and project management by providing API service account credentials:

```json
{
  "MONGODB_URI": "mongodb+srv://user:pass@cluster.mongodb.net/mydb",
  "MDB_MCP_API_CLIENT_ID": "your-atlas-service-account-id",
  "MDB_MCP_API_CLIENT_SECRET": "your-atlas-service-account-secret"
}
```

### Disable specific tools

Disable write tools while keeping read operations available:

```json
{
  "MONGODB_URI": "mongodb+srv://user:pass@cluster.mongodb.net/mydb",
  "MDB_MCP_DISABLED_TOOLS": "insert-one,insert-many,update-one,update-many,delete-one,delete-many,drop-collection,drop-database"
}
```

### Enable logging

Write server logs to a file for debugging:

```json
{
  "MONGODB_URI": "mongodb+srv://user:pass@cluster.mongodb.net/mydb",
  "MDB_MCP_LOG_PATH": "/tmp/mongodb-mcp.log"
}
```

## Security

- `mongo.config.json` contains credentials. It is excluded from version control via `.gitignore`.
- Do not commit `mongo.config.json` to any repository.
- Use Atlas API service accounts with the minimum required permissions.
- Consider `MDB_MCP_READ_ONLY` mode for exploratory or shared environments.
