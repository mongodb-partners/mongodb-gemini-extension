/**
 * Configuration loading tests
 * Verifies that run.js correctly reads mongo.config.json, maps config keys
 * to environment variables, and handles errors.
 */
import { describe, it, expect, beforeEach, afterEach } from "vitest";
import fs from "fs";
import path from "path";
import { execFileSync } from "child_process";

const ROOT = path.resolve(import.meta.dirname, "..");
const CONFIG_PATH = path.join(ROOT, "mongo.config.json");
const RUN_JS_PATH = path.join(ROOT, "run.js");

/**
 * Helper: run `node run.js` with a timeout and capture output.
 * The MCP server expects stdio transport so it will hang waiting for input.
 * We use a short timeout and capture stderr/stdout for error cases.
 * For success cases, we just check it doesn't crash immediately.
 */
function runExtension(opts = {}) {
  const env = { ...process.env, ...opts.env };
  try {
    const result = execFileSync("node", [RUN_JS_PATH], {
      cwd: ROOT,
      timeout: 3000,
      env,
      stdio: ["pipe", "pipe", "pipe"],
      encoding: "utf8",
    });
    return { exitCode: 0, stdout: result, stderr: "" };
  } catch (err) {
    // If it timed out, that means the server started successfully (it's
    // waiting for stdio input), which is a success for our purposes.
    if (err.killed || err.signal === "SIGTERM") {
      return {
        exitCode: 0,
        stdout: err.stdout || "",
        stderr: err.stderr || "",
        timedOut: true,
      };
    }
    return {
      exitCode: err.status,
      stdout: err.stdout || "",
      stderr: err.stderr || "",
    };
  }
}

describe("Configuration loading", () => {
  let originalConfig = null;

  beforeEach(() => {
    // Preserve existing config if present
    if (fs.existsSync(CONFIG_PATH)) {
      originalConfig = fs.readFileSync(CONFIG_PATH, "utf8");
    }
  });

  afterEach(() => {
    // Restore original config
    if (originalConfig !== null) {
      fs.writeFileSync(CONFIG_PATH, originalConfig);
    } else if (fs.existsSync(CONFIG_PATH)) {
      fs.unlinkSync(CONFIG_PATH);
    }
  });

  it("TC-002: should start successfully with valid MONGODB_URI config", () => {
    fs.writeFileSync(
      CONFIG_PATH,
      JSON.stringify({
        MONGODB_URI: "mongodb://localhost:27017/testdb",
      })
    );

    const result = runExtension();
    // Server should either timeout (meaning it started and is waiting for
    // stdio input) or exit 0
    expect(
      result.timedOut || result.exitCode === 0,
      `Expected server to start but got exit code ${result.exitCode}. stderr: ${result.stderr}`
    ).toBe(true);
  });

  it("TC-003: should map all config keys to MDB_MCP_* environment variables", () => {
    // This test verifies the config key mapping logic by checking run.js source
    const runJsContent = fs.readFileSync(RUN_JS_PATH, "utf8");

    const expectedMappings = [
      "MDB_MCP_CONNECTION_STRING",
      "MDB_MCP_READ_ONLY",
      "MDB_MCP_INDEX_CHECK",
      "MDB_MCP_API_CLIENT_ID",
      "MDB_MCP_API_CLIENT_SECRET",
    ];

    for (const envVar of expectedMappings) {
      expect(
        runJsContent.includes(envVar),
        `run.js should reference ${envVar}`
      ).toBe(true);
    }
  });

  it("TC-004: should exit with error when mongo.config.json is missing (INV-003)", () => {
    // Ensure no config file exists
    if (fs.existsSync(CONFIG_PATH)) {
      fs.unlinkSync(CONFIG_PATH);
    }
    originalConfig = null; // Don't try to restore

    const result = runExtension();
    expect(result.exitCode).not.toBe(0);
    expect(result.stderr).toMatch(/config|not found|mongo\.config\.json/i);
  });

  it("TC-005: should exit with error when MONGODB_URI is missing from config (INV-004)", () => {
    fs.writeFileSync(CONFIG_PATH, JSON.stringify({ OTHER_KEY: "value" }));

    const result = runExtension();
    expect(result.exitCode).not.toBe(0);
    expect(result.stderr).toMatch(/MONGODB_URI/i);
  });

  it("TC-009: should exit with error on malformed JSON in config (INV-009)", () => {
    fs.writeFileSync(CONFIG_PATH, "{ this is not valid json }}}");

    const result = runExtension();
    expect(result.exitCode).not.toBe(0);
    expect(result.stderr.length).toBeGreaterThan(0);
  });
});
