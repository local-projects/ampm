@echo off

::Starts localization of environment variables in a batch file
@setlocal 

goto environment

:environment
@setlocal enableextensions

:: Storing all input variables
set OWNER=%1
set REPO=%2
set APP_NAME=%3

set releaseUrl=https://api.github.com/repos/%OWNER%/%REPO%/releases
set tagUrl=https://api.github.com/repos/%OWNER%/%REPO%/releases/tags/%RELEASE%

rem :: ============================================================== CHECKING FOR CREDENTIALS DIRECTORY
REM Check for creds directory and create if it does not exist
if not exist "c:\.creds\" goto makecreds
cd c:\.creds\

:makecreds
REM Creating creds directory. YOU NEED TO ADD THE GITHUB TOKEN
cd c:/
mkdir .creds
cd .creds

for /F %%i in (github_token.txt) do (
echo Files containing %%i
set TOKEN=%%i
)

rem :: ============================================================== CHECKING FOR LOCALPROJECTS DIRECTORY
REM Check for local projects directory and create if it does not exist
if not exist "c:\localprojects\" goto makelp
cd c:\localprojects\

:makelp
REM Creating LOCAL PROJECTS directory
cd c:/
mkdir localprojects
cd localprojects

rem :: ============================================================== FIND LATEST RELEASE RELEASE
call curl -vLJO -H "Authorization: token %TOKEN%" "%releaseUrl%"

REM - PARSING RESPONSE FOR LATEST
call jq .[0].assets[0].url releases > zip_url.tmp
set /p ZIP_URL=<zip_url.tmp
echo %ZIP_URL%

call jq .[0].assets[0].name releases > release_url.tmp
set /p RELEASE=<release_url.tmp
echo %RELEASE%

rem :: ============================================================== DOWNLOAD RELEASE
call curl -vLJO -H "Authorization: token %TOKEN%" -H "Accept: application/octet-stream" %ZIP_URL%

rem :: ============================================================== DELETE OLD APP
rmdir %APP_NAME%

rem :: ============================================================== UNZIP RELEASE
call unzip -o %RELEASE% -d %APP_NAME%
del release_url.tmp
del zip_url.tmp
del releases
del %RELEASE%

