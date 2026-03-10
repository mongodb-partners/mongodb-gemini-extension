#!/usr/bin/env node

/**
 * MongoDB Gemini CLI Extension — Entry Point
 *
 * Thin wrapper that reads mongo.config.json, maps configuration keys to the
 * environment variables expected by mongodb-mcp-server, and starts the MCP
 * server via StdioRunner.
 *
 * This file is invoked by the Gemini CLI based on gemini-extension.json.
 */

import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const CONFIG_PATH = path.join(__dirname, "mongo.config.json");

/**
 * Mapping from mongo.config.json keys to the environment variables expected
 * by mongodb-mcp-server. See:
 * https://github.com/mongodb-js/mongodb-mcp-server#configuration
 */
const CONFIG_TO_ENV = {
  MONGODB_URI: "MDB_MCP_CONNECTION_STRING",
  MDB_MCP_CONNECTION_STRING: "MDB_MCP_CONNECTION_STRING",
  MDB_MCP_READ_ONLY: "MDB_MCP_READ_ONLY",
  MDB_MCP_INDEX_CHECK: "MDB_MCP_INDEX_CHECK",
  MDB_MCP_MAX_DOCUMENTS_PER_QUERY: "MDB_MCP_MAX_DOCUMENTS_PER_QUERY",
  MDB_MCP_MAX_BYTES_PER_QUERY: "MDB_MCP_MAX_BYTES_PER_QUERY",
  MDB_MCP_DISABLED_TOOLS: "MDB_MCP_DISABLED_TOOLS",
  MDB_MCP_API_CLIENT_ID: "MDB_MCP_API_CLIENT_ID",
  MDB_MCP_API_CLIENT_SECRET: "MDB_MCP_API_CLIENT_SECRET",
  MDB_MCP_LOG_PATH: "MDB_MCP_LOG_PATH",
  MDB_MCP_VOYAGE_AI_API_KEY: "MDB_MCP_VOYAGE_AI_API_KEY",
};

async function main() {
  // --- 1. Read and validate configuration ---

  if (!fs.existsSync(CONFIG_PATH)) {
    console.error("ERROR: Configuration file not found!");
    console.error(
      `Please create 'mongo.config.json' in the extension directory: ${__dirname}`
    );
    console.error(
      "You can copy the template: cp mongo.config.json.example mongo.config.json"
    );
    process.exit(1);
  }

  let config;
  try {
    const raw = fs.readFileSync(CONFIG_PATH, "utf8");
    config = JSON.parse(raw);
  } catch (err) {
    console.error("ERROR: Failed to parse mongo.config.json:");
    console.error(err.message);
    process.exit(1);
  }

  // Require at least a connection string
  if (!config.MONGODB_URI && !config.MDB_MCP_CONNECTION_STRING) {
    console.error(
      "ERROR: MONGODB_URI (or MDB_MCP_CONNECTION_STRING) not found in mongo.config.json"
    );
    console.error(
      'Please add "MONGODB_URI": "mongodb+srv://..." to your config file.'
    );
    process.exit(1);
  }

  // --- 2. Map config keys to environment variables ---

  for (const [configKey, envVar] of Object.entries(CONFIG_TO_ENV)) {
    if (config[configKey] !== undefined && config[configKey] !== "") {
      process.env[envVar] = String(config[configKey]);
    }
  }

  // --- 3. Start the MCP server via StdioRunner ---

  try {
    const { StdioRunner, parseUserConfig } = await import("mongodb-mcp-server");

    // parseUserConfig reads MDB_MCP_* env vars (which we just set above)
    // and CLI arguments to produce a UserConfig object.
    const { parsed: userConfig, error, warnings } = parseUserConfig({
      args: process.argv.slice(2),
    });

    if (error) {
      console.error("ERROR: Invalid configuration:", error);
      process.exit(1);
    }

    for (const warning of warnings) {
      console.error("WARNING:", warning);
    }

    const runner = new StdioRunner({ userConfig });
    await runner.start();
  } catch (err) {
    console.error("ERROR: Failed to start MongoDB MCP Server:");
    console.error(err.message);
    process.exit(1);
  }
}

main();
