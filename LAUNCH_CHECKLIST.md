# VANTA Launch Checklist

## Phase 15 — Production hardening

- [x] Bounded PostgreSQL pool
- [x] Database connect/idle timeouts
- [x] Monitoring authentication
- [x] Health response hardened
- [x] Security response headers
- [x] Production TypeScript config
- [x] Render web/worker/cron/database blueprint

## Phase 16 — Deploy

- [ ] GitHub repository connected
- [ ] Render Blueprint created
- [ ] Blockscout API key entered
- [ ] VANTA_WALLETS entered
- [ ] Database migrated
- [ ] Web service healthy
- [ ] Worker running
- [ ] Scheduled E2E check active

## Phase 16 — Final QA

- [ ] `npm run preflight`
- [ ] `npm run production:check`
- [ ] `npm run qa:final`
- [ ] `npm run e2e:live`
- [ ] `npm run public:smoke`
- [ ] Dashboard renders from live DB
- [ ] Smart Money renders from live DB
- [ ] Signals render from live DB
- [ ] Alerts render from live DB
- [ ] Wallet profiles render from live DB
- [ ] Mobile smoke test
- [ ] 404/error/loading states checked

## Launch gate

VANTA is **not** considered launched until the live E2E and public smoke checks pass on the deployed service.
