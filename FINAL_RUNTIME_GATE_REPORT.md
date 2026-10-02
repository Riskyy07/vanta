# VANTA — Final Runtime Gate Report

Date: 2026-10-02
Release source: VANTA FINAL RELEASE V1.4 + final source cleanup

## Verified in the available environment
- Preflight: PASS
- Production configuration: PASS
- UI/dead-link source checks: 162/162 PASS
- Data integrity: 50/50 PASS
- Release validation: 44/44 PASS
- Final QA static checks: 43/43 PASS
- Intelligence: 5/5 PASS
- Intelligence source: 8/8 PASS
- Unified Dashboard: 4/4 PASS
- Discovery V3: 2/2 PASS
- Signal V2: 2/2 PASS
- Alerts: 4/4 PASS
- Wallet Timeline: 4/4 PASS
- Behavior History: 2/2 PASS

## Additional source fixes in this gate
- API now masks incomplete asset USD aggregates as null rather than exposing stored sentinel zero values
- Dashboard signal count excludes neutral/incomplete aggregate rows
- Dashboard no longer colors unknown wallet/signal flows as positive when USD coverage is unavailable

## Runtime gates still requiring the user's real environment
1. Install production dependencies
2. Run the real Next production build
3. Provide a real PostgreSQL connection
4. Provide a Blockscout PRO API key
5. Configure one or more Base wallet addresses
6. Run database migration
7. Run live ingestion
8. Run live E2E
9. Deploy web + worker + cron
10. Run public smoke tests against the deployed URL

## Why these are not marked PASS here
The execution environment has no outbound DNS access to npm registry / external services, so npm install cannot complete here. No production PostgreSQL, Blockscout credential, or deployed public URL is available in this environment.

The source-level TypeScript check was also validated with temporary dependency stubs to isolate project-level syntax/type issues; it passed without project-code errors, but this is not a substitute for a real dependency-backed `tsc --noEmit` run.

## Release rule
Do not label VANTA as production-live until `e2e:live`, production build, and public smoke tests pass against the real configured environment.
