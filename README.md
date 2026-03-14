# GitHub Trend Radar KR

한국 사용자를 위한 GitHub 트렌드 레이더 MVP 저장소입니다.

## Development

If `pnpm` is not available locally, use `corepack pnpm <command>` or run `corepack enable` once first.

- `pnpm install`
- `cp .env.example .env` (PowerShell: `Copy-Item .env.example .env`)
- `pnpm db:up`
- `pnpm db:migrate`
- `pnpm db:generate`
- `pnpm test`
- `pnpm build`
- `pnpm dev:web`

## Local Database

The local Prisma/PostgreSQL workflow is package-owned by `@repo/db`, while the repo root keeps the operator-facing runtime files.

1. Copy `.env.example` to `.env`.
2. Start PostgreSQL with `pnpm db:up` or `docker compose up -d`.
3. Apply the initial schema with `pnpm db:migrate`.
4. Refresh the generated Prisma client with `pnpm db:generate`.
5. Run the package check with `pnpm --filter @repo/db test`.
