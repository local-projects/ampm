REM If the App is already running, kill it
taskkill /f /im App.exe

REM === Start the app ===

REM -- METHOD 1 --
REM (This won't show application logs in the console, but it also
REM doesn't need to send heartbeats.)
REM C:\localprojects\path-to-app-exe\App.exe

REM -- METHOD 2 --
REM (This will show app logs in a separate console, but it requires
REM that the app sends heartbeats.)
cd C:\localprojects\path-to-app-exe
start /high App.exe