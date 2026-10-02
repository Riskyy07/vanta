# VANTA — Final Source Freeze

## Release status

**Source frozen — pre-launch runtime gate pending**

The VANTA product source has completed the final offline pass covering UI/UX consistency, route/dead-link integrity, data rendering, error-boundary safety, accessibility polish, and production source cleanup

The release is **not yet production-live** because live PostgreSQL, Blockscout access, deployment, and blockchain-to-dashboard E2E still require a real configured environment

## Final offline verification

- UI/dead-link source checks: **161/161 PASS**
- Final QA static checks: **43/43 PASS**
- Release validation: **44/44 PASS**
- Data integrity checks: **50/50 PASS**
- Intelligence checks: **5/5 PASS**
- Intelligence source checks: **8/8 PASS**
- Unified Dashboard checks: **4/4 PASS**
- Discovery V3 checks: **2/2 PASS**
- Signal V2 checks: **2/2 PASS**
- Alerts checks: **4/4 PASS**
- Wallet Timeline checks: **4/4 PASS**
- Behavior History checks: **2/2 PASS**
- Live activation static checks: **14/14 PASS**
- All `scripts/*.mjs` syntax checks: **PASS**

## Final pass fixes

### UI/UX
- Explicit keyboard focus states for links, buttons and form controls
- Mobile navigation now remains usable on narrow screens via horizontal scrolling
- Button elements now receive consistent typography, cursor, border and hover behavior
- Timeline charts distinguish incomplete USD data from positive/negative flow bars
- Landing visual uses conceptual intelligence nodes instead of synthetic market values presented as live data

### Route integrity
- Added source-level UI/dead-link validation
- Verified required application routes and wallet profile route
- Invalid wallet profile URLs now resolve through the framework 404 path

### Data rendering
- Demo Asset Intelligence now carries explicit USD availability metadata
- Wallet asset counting uses canonical token identity
- Incomplete 30D USD coverage is never described as a zero-dollar calculation
- Asset Intelligence Matrix now separates total flow from smart-money flow
- Wallet transfer rows render unknown USD values as `—`
- Unified dashboard pipeline status distinguishes `Awaiting` from `Healthy`

### Production safety
- Root Next.js layout now contains explicit `<html>` and `<body>` tags
- Intelligence and relationship error boundaries no longer expose raw runtime error messages to users
- Discovery API now has production-safe error handling and `no-store` response headers
- Stale preview/audit artifacts were removed from the production source package

## Runtime launch gate

The following still require a real environment:

1. Install production dependencies
2. Configure `DATABASE_URL`
3. Configure Blockscout access and `BLOCKSCOUT_API_KEY` when required
4. Configure `VANTA_WALLETS`
5. Run migrations
6. Ingest real Base Mainnet transfers
7. Confirm PostgreSQL transfer, score, behavior and ingestion-state rows
8. Run `npm run e2e:live`
9. Run `npm run build`
10. Deploy the web service and persistent worker
11. Run public smoke tests

VANTA should only be declared production-live after the deployed live E2E path passes
