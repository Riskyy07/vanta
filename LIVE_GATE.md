# VANTA — LIVE DATA GATE

## Gate target
Prove the real runtime path:

Base Mainnet → Blockscout → ingestion worker → PostgreSQL → wallet score/behavior → signals → dashboard

## Current code status
- Base Mainnet chain: 8453
- Blockscout REST base: `https://api.blockscout.com/8453/api/v2`
- Server-side API key wiring: enabled
- `.env.local` is now loaded by CLI scripts
- Live-check now fails on missing API key, wallet, or incomplete schema
- Live E2E now verifies provider + database + wallet ingestion + score + behavior + ingestion state
- Docker builder no longer assumes a missing lockfile

## Required runtime values
```env
DATABASE_URL=
BLOCKSCOUT_API_BASE_URL=https://api.blockscout.com/8453/api/v2
BLOCKSCOUT_API_KEY=
BLOCKSCOUT_CHAIN_ID=8453
VANTA_WALLETS=0x...
VANTA_REQUIRE_LIVE_DATA=true
```

## Exact gate sequence
```bash
npm install
npm run live:check
npm run live:ingest
npm run e2e:live
npm run qa:final
npm run production:check
npm run build
```

## Gate interpretation
- `live:check` PASS = credentials/provider/database/schema reachable
- `live:ingest` PASS = real transfer data stored and intelligence calculations refreshed
- `e2e:live` PASS = Blockscout → PostgreSQL → wallet score/behavior/state verified
- `qa:final` + `production:check` + `build` PASS = release candidate can proceed to deployment

No launch claim is valid until the real `e2e:live` check passes on the configured environment.

Deployment hardening note (2026-10-01): VANTA uses session-level PostgreSQL advisory locks in the ingestion worker, so the Render Blueprint uses a direct Postgres connection (`connectionString`) rather than PgBouncer transaction pooling.
