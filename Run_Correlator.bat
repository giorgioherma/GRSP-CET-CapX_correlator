@echo off
setlocal
cd /d "%~dp0"

set "INPUT=%~1"
if "%INPUT%"=="" (
  echo GRSP Correlator v0.1.1
  echo.
  set /p "INPUT=Paste the combined capture ZIP or folder path: "
)

if "%INPUT%"=="" (
  echo No input supplied.
  pause
  exit /b 1
)

where py >nul 2>&1
if %errorlevel%==0 (
  py -3 "%~dp0GRSP_Correlator.py" "%INPUT%" --open
) else (
  where python >nul 2>&1
  if not %errorlevel%==0 (
    echo Python was not found. Install Python 3.10+ or use the packaged Windows EXE build.
    pause
    exit /b 1
  )
  python "%~dp0GRSP_Correlator.py" "%INPUT%" --open
)

if not %errorlevel%==0 (
  echo.
  echo Correlation failed. Read the error above.
  pause
  exit /b 1
)

echo.
echo Correlation complete.
pause
