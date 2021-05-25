# ampm Docker sample

Provided is a TaskScheduler file `Start_App.xml` for Windows that will automatically run the `startup.bat` file on startup. This batch file will then call ampm, which builds the containers specified in `docker-compose.yml` using the environments file `.env`.