# Deployments

## Instructions

1. Create a folder at `C:\localprojects` to store ampm and releases.

2. Install ampm from source to `C:\localprojects\ampm`.

3. Create a new folder for your app at `C:\localprojects\my-app-name` and add a `ampm.json` configuration file to it, using examples in *samples* for reference.

   Update your configuration file to have your desired settings for persistance, logging, etc.

   *Note: Make sure your app can support the persistance features enabled in your configuration file. For example, if your app does not produce a PID, it will require heartbeats to enable persistance.*

4. Create a new task in TaskScheduler that runs the command `ampm C:\\localprojects\\my-app-name\\ampm.json`. Configure the task settings appropriately, for example, to start on computer startup after 1 minute, etc.

