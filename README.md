
## Production release

This source freeze includes `render.yaml`, production hardening, live-gate runbooks, and the `production:ready`, `validate:release`, and `ui:check` checks.

# VANTA — Smart Money Intelligence

VANTA is an on-chain intelligence dashboard for Base Mainnet (chain ID 8453). The current intelligence layer connects **wallet × asset × behavior × capital flow × momentum × signal contribution** into one view.

## Intelligence Layer

### `/intelligence`
- Smart Money Leaderboard
- Asset Intelligence Matrix
- Wallet, asset and behavior filters
- Smart Score / Capital thresholds
- Momentum, 7D flow and signal-contribution sorting
- USD values are shown only when the measured transfer window has complete USD coverage

### `/intelligence/relationship?wallet=...&asset=...`
- Relationship-level Smart Score and Capital Score
- 7D capital flow and momentum
- 30D wallet × asset flow timeline
- Direct signal observations
- Wallet behavior history

### `/api/intelligence`
Returns the current intelligence dataset as JSON for integrations or future clients

## Data model

```text
Base Mainnet
  ↓
Blockscout
  ↓
Ingestion Worker
  ↓
PostgreSQL
  ↓
Wallet Score + Behavior
  ↓
Wallet × Asset Intelligence
  ↓
Signal Contribution / Momentum
  ↓
Leaderboard + Asset Matrix + Relationship Drilldown
```

## Live-data safety

`VANTA_REQUIRE_LIVE_DATA=true` prevents the intelligence routes from silently falling back to demo data when `DATABASE_URL` is missing. For local UI work, omit it or set it to `false`.

## Environment

Copy `.env.example` to `.env.local` and configure. CLI scripts load `.env.local` automatically:

```env
DATABASE_URL=
BLOCKSCOUT_API_KEY=
BLOCKSCOUT_API_BASE_URL=https://api.blockscout.com/8453/api/v2
BLOCKSCOUT_CHAIN_ID=8453
VANTA_WALLETS=0xYOUR_BASE_WALLET
VANTA_WORKER_INTERVAL_MS=300000
VANTA_WORKER_ONCE=false
VANTA_MAX_PAGES_PER_WALLET=50
VANTA_REQUIRE_LIVE_DATA=true
```

## Run

```bash
npm install
npm run migrate
npm run ingest -- 0xYOUR_BASE_WALLET
npm run worker
npm run dev
```

Open `/intelligence` after ingestion has populated `wallet_scores`, `wallet_behaviors` and `transfers`.

## Production packaging

A standalone production Dockerfile is included. Build and run it after configuring the environment:

```bash
docker build -t vanta-intelligence .
docker run --env-file .env.local -p 3000:3000 vanta-intelligence
```

The intelligence pages and APIs are forced dynamic and send `Cache-Control: no-store` so live wallet/asset data is not accidentally served from a stale page cache.

## Validation

```bash
npm run quality
npm run discovery:test
npm run preflight
npm run intelligence:test
npm run intelligence:source-check
npm run build
npm run ui:check
```

Static checks validate source contracts only. Full Next.js build and live PostgreSQL/Blockscout E2E require the project dependencies, network access, and real deployment credentials.

## Important data rule

VANTA does not invent USD values. If a relationship contains incomplete USD coverage, its dollar flow is rendered as `—`.

## Live Data Activation

See `LIVE_ACTIVATION.md` for the production path from Base Mainnet → Blockscout → PostgreSQL → VANTA intelligence.
Run `npm run live:check` before the first ingestion.

## One-click Windows live gate

After `.env.local` is configured, double-click `RUN-LIVE-GATE.bat`. It installs dependencies, checks Blockscout/PostgreSQL, applies the schema, ingests the configured wallet(s), runs live E2E, final QA, and the production configuration check. It stops at the first failed gate.
