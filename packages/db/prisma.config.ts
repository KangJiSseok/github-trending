import path from "node:path";
import { fileURLToPath } from "node:url";
import { config as loadEnv } from "dotenv";
import { defineConfig } from "prisma/config";

const packageDirectory = path.dirname(fileURLToPath(import.meta.url));

loadEnv({
  path: path.resolve(packageDirectory, "../../.env"),
  quiet: true
});

export default defineConfig({
  schema: "prisma/schema.prisma",
  migrations: {
    path: "prisma/migrations"
  }
});
