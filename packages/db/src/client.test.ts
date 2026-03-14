import { describe, expect, it } from "vitest";
import { createPrismaClient } from "./client";

describe("createPrismaClient", () => {
  it("returns a configured Prisma client instance", async () => {
    process.env.DATABASE_URL =
      "postgresql://postgres:postgres@localhost:5432/github_trending?schema=public";

    const client = createPrismaClient();

    expect(client).toBeDefined();
    expect(typeof client.$connect).toBe("function");
    expect(typeof client.$disconnect).toBe("function");

    await client.$disconnect();
  });
});
