import { PrismaPg } from "@prisma/adapter-pg";
import { PrismaClient } from "../generated/client/client";

export function createPrismaClient(): PrismaClient {
  const connectionString = process.env.DATABASE_URL;

  if (!connectionString) {
    throw new Error("DATABASE_URL is required to create a Prisma client.");
  }

  const adapter = new PrismaPg({ connectionString });

  return new PrismaClient({ adapter });
}
