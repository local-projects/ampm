REM Remove the previous docker process
cd C:\localprojects\ampm\samples\Docker
docker-compose kill

REM Pull the new containers (if using releases from your own registry)
REM docker-compose pull

REM Start a new docker process
docker-compose up
cmd /k