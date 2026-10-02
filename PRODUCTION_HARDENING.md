# VANTA Production Hardening

## Completed in this release candidate

- PostgreSQL connection handling moved from a single long-lived client to a bounded `pg` pool with connect/idle/max-use controls
- Database TLS is enabled explicitly with `DATABASE_SSL=true` in production; local development can keep it false
- Monitoring endpoint protected by `x-vanta-monitoring-secret`
- Health endpoint no longer returns raw database errors
- API responses default to `Cache-Control: no-store`
- Security headers added: X-Content-Type-Options, X-Frame-Options, Referrer-Policy, Permissions-Policy, and production HSTS
- Production config requires `VANTA_MONITORING_SECRET`
- Render Blueprint added with separate web, worker, scheduled live-E2E check, and pooled PostgreSQL
- Worker start path runs idempotent migrations before starting the continuous worker
- Added typecheck/release-validation/production-ready scripts

## Runtime gate that still requires real credentials

`DATABASE_URL`, `BLOCKSCOUT_API_KEY`, and `VANTA_WALLETS` must be supplied in the deployment environment. The API key is a secret and must not be placed in client-side `NEXT_PUBLIC_*` variables. Blockscout documents API keys for Pro API endpoints. 

## Deployment target

The included `render.yaml` targets Render because the VANTA architecture needs a web service plus a continuously running worker and a managed PostgreSQL instance. Render supports Docker/Node web services, background workers, cron jobs, managed Postgres, health checks, and Blueprint-defined environment variables.
