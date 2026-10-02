# VANTA Live Data Activation

VANTA is configured for **Base Mainnet (chain ID 8453)** and Blockscout REST API v2.

## 1. Configure environment

Copy `.env.example` to `.env.local` and set (the CLI scripts now load `.env.local` automatically):

- `DATABASE_URL`
- `BLOCKSCOUT_API_KEY`
- `VANTA_WALLETS`
- `VANTA_REQUIRE_LIVE_DATA=true`

The default Blockscout PRO REST base is:

`https://api.blockscout.com/8453/api/v2`

Blockscout documents this Base-specific REST route and chain ID 8453 in its current API documentation. The API key is sent server-side as the `apikey` query parameter.

## 2. Install

```bash
npm install
```

## 3. Verify everything

```bash
npm run live:check
```

This checks configuration, the seed wallet format, PostgreSQL, the VANTA schema, and a real Blockscout token-transfer request.

## 4. Create/update database schema

```bash
npm run migrate
```

## 5. First live ingestion

```bash
npm run ingest -- 0xYOUR_BASE_WALLET
```

The worker is idempotent and stores normalized token transfer data, data quality, wallet score, behavior, and ingestion state.

## 6. Continuous ingestion

```bash
npm run worker
```

The default interval is 5 minutes. Set `VANTA_WORKER_ONCE=true` for a single cycle.

## 7. Production deployment

Run the Next.js app separately from the worker:

```bash
npm run build
npm run start
npm run worker
```

Use a managed PostgreSQL provider in production. Do not commit `.env.local` or API keys.

## Important live-data behavior

- No USD value is invented when Blockscout does not provide one
- `amount_normalized` is only populated when token decimals are known
- Existing transfers are idempotently upserted using `transfer_key`
- Wallet ingestion is protected with a PostgreSQL advisory lock
- Failed runs are recorded in `ingestion_runs` and `ingestion_state`
- `VANTA_REQUIRE_LIVE_DATA=true` prevents the UI from silently treating demo data as production data

## Optional local PostgreSQL

For local development only:

```bash
docker compose -f docker-compose.local.yml up -d
```

Then use:

```env
DATABASE_URL=postgresql://USER:PASSWORD@localhost:5432/vanta
```

Change the local password before exposing the database beyond localhost.
