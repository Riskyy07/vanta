@echo off
setlocal
cd /d "%~dp0"
if not exist .env.local (
  echo Missing .env.local
  echo Copy .env.example to .env.local, fill in DATABASE_URL, BLOCKSCOUT_API_KEY, and VANTA_WALLETS, then run this file again.
  pause
  exit /b 2
)
echo [1/6] Installing dependencies...
npm install --no-audit --no-fund
if errorlevel 1 goto :fail
echo [2/6] Live provider/database gate...
npm run live:check
if errorlevel 1 goto :fail
echo [3/6] Applying database schema and ingesting real data...
npm run live:ingest
if errorlevel 1 goto :fail
echo [4/6] Real end-to-end verification...
npm run e2e:live
if errorlevel 1 goto :fail
echo [5/6] Final QA...
npm run qa:final
if errorlevel 1 goto :fail
echo [6/6] Production configuration...
npm run production:check
if errorlevel 1 goto :fail
echo.
echo LIVE DATA GATE PASSED
pause
exit /b 0
:fail
echo.
echo LIVE DATA GATE STOPPED — check the first failed command above.
pause
exit /b 1
