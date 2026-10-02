# VANTA — Final QA Pass

This release freeze includes the final pre-GitHub audit pass for UI/UX, route integrity, data rendering, accessibility, error boundaries, and production source cleanup.

## Included fixes
- Root App Router layout now provides explicit html/body tags
- Intelligence error boundary no longer exposes raw runtime errors
- Mobile navigation remains reachable through horizontal scrolling
- Keyboard focus states added across links, controls, filters, and buttons
- Timeline charts now distinguish incomplete USD bars from positive flow bars
- Wallet transfer rows keep unknown USD values as `—` instead of `+—` / `-—`
- Demo Asset Intelligence carries explicit USD coverage metadata
- Wallet asset counting uses canonical token-address identity
- Behavior history avoids presenting an incomplete 30D USD calculation as zero
- Asset Intelligence matrix now separates total flow from smart-money flow
- Discovery API now has production-safe error handling and no-store headers
- Landing visual data is conceptual rather than presenting synthetic market numbers as live data
- Source-level UI/dead-link verification added

## Runtime boundary
This is a source-frozen pre-launch release. PostgreSQL, Blockscout credentials, live ingestion, deployment, and blockchain-to-dashboard E2E still require a real configured environment.
