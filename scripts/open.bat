@echo off
setlocal enabledelayedexpansion

REM Check if docker-compose is available
where docker-compose >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: docker-compose not found. Please install Docker Compose.
    exit /b 1
)

REM Get the URL from docker-compose with error handling
for /f "tokens=*" %%i in ('docker-compose port webserver 80 2^>nul') do set url_output=%%i
if "!url_output!"=="" (
    echo Error: Could not get webserver port from docker-compose. Make sure containers are running.
    exit /b 1
)

REM Replace 0.0.0.0 with localhost
set url=!url_output:0.0.0.0=localhost!
set url=http://!url!

REM Open the URL using Windows start command
echo Opening: !url!
start "Opening Browser" !url!

if %errorlevel% neq 0 (
    echo Error: Could not open browser. Please open manually: !url!
    exit /b 1
)