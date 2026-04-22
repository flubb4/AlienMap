@echo off
REM ============================================================
REM  Re-encrypt the Campaign Book after editing _source/*.html
REM ============================================================
REM  Source:  _source\RecallAuthority_CampaignBook.html  (plaintext, gitignored)
REM  Output:  RecallAuthority_CampaignBook.html          (encrypted, committed)
REM  Salt:    .staticrypt.json (kept so re-encryption is stable)
REM ============================================================

cd /d "%~dp0"

if not exist "_source\RecallAuthority_CampaignBook.html" (
  echo.
  echo [ERROR] _source\RecallAuthority_CampaignBook.html not found.
  echo         Put your plaintext campaign book there and try again.
  echo.
  pause
  exit /b 1
)

echo.
set /p PWD=Enter Campaign Book password:

if "%PWD%"=="" (
  echo [ERROR] No password entered.
  pause
  exit /b 1
)

echo.
echo Encrypting Campaign Book with staticrypt...
echo.

call npx -y staticrypt "_source\RecallAuthority_CampaignBook.html" -p "%PWD%" --short ^
  --template-title "RECALL AUTHORITY - MU/TH/UR 9000" ^
  --template-instructions "Weyland-Yutani // Classified // 2183" ^
  --template-placeholder "Access Code" ^
  --template-button "AUTHORIZE" ^
  --template-error "ZUGRIFF VERWEIGERT" ^
  --template-remember "Session merken" ^
  --template-color-primary "#4dff91" ^
  --template-color-secondary "#080c09" ^
  -d .

set PWD=

if errorlevel 1 (
  echo.
  echo [ERROR] Encryption failed.
  pause
  exit /b 1
)

echo.
echo [OK] RecallAuthority_CampaignBook.html encrypted at repo root.
echo      Commit and push to publish.
echo.
pause
