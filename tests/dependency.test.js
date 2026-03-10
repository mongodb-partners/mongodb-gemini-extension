/**
 * Dependency verification tests
 * Verifies that mongodb-mcp-server is installed and exports the expected API.
 */
import { describe, it, expect } from "vitest";

describe("mongodb-mcp-server dependency", () => {
  it("TC-007a: should be importable", async () => {
    const mod = await import("mongodb-mcp-server");
    expect(mod).toBeDefined();
  });

  it("TC-007b: should export StdioRunner", async () => {
    const { StdioRunner } = await import("mongodb-mcp-server");
    expect(StdioRunner).toBeDefined();
    expect(typeof StdioRunner).toBe("function");
  });

  it("TC-007c: should export Server class", async () => {
    const { Server } = await import("mongodb-mcp-server");
    expect(Server).toBeDefined();
    expect(typeof Server).toBe("function");
  });

  it("TC-007d: should export Session class", async () => {
    const { Session } = await import("mongodb-mcp-server");
    expect(Session).toBeDefined();
    expect(typeof Session).toBe("function");
  });

  it("TC-007e: should export configuration utilities", async () => {
    const mod = await import("mongodb-mcp-server");
    // At least one of these should exist
    const hasConfig =
      mod.UserConfig !== undefined ||
      mod.parseUserConfig !== undefined ||
      mod.UserConfigSchema !== undefined;
    expect(hasConfig).toBe(true);
  });
});
