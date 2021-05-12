# LP Fork of ampm 



## Changes

ampm is used in FLDC to launch applications and monitor their health via heartbeats and PID monitoring. It is also used to download new releases on each machine. During FLDC production period, a number of changes were made to AMPM for added functionality. Below are a list of all the changes.

### socket.io v3.X

```socket.io``` and ```socket.io-client``` were updated to work with 3.X versions of ```socket.io```. Note that ```socket.io``` versions are not always backwards compatible when new versions are released. 

		"socket.io": "^3.1.1",
		"socket.io-client": "^3.1.1",
### Monitoring PID & Downtime

ampm only relaunches an application when the persistence manager is configured to do so (i.e. heartbeats, startup timeout, max memory, etc.). See documentation for the persistence manager [here](https://github.com/local-projects/ampm#configuration-persistence).  

For FLDC, monitoring the PID of the launch command was added and defaulted to true. To turn monitoring the PID of the launch command off, add the following to ```ampm.json``` file

```json
"persistence": {  
	// MONITOR PID 
    "monitorPID": false
}
```

#### Reasons to turn monitoring PID off

* Launch command does not have a PID to monitor. For example, the ```FLDC Conversation Booth``` needs to be started via a startup bat file due to the pipe mechanisms used for piping OF video and audio data to ```ffmpeg``` via ```std::out```. For this reason, a start up script launches the ```exe``` file in its own window. Heartbeats are then used as the monitoring mechanism.  
* Launching ```chrome.exe``` does not produce a PID to monitor. If chrome has to be used, turn monitoring PID off and ensure heartbeats are a feature in the software.  Alternatively, it is recommended to use chromium instead of chrome as chromium has a PID to monitor. 

#### Downtime 

Max down time for the application is currently set in ```consoleState.js``` model. Since applications should default to using heartbeats as the monitoring mechanism, this was not set as a configurable variable.

```

  // The amount of time before the app relaunches when monitoring PID
  // If the heartbeat timeout exceeds this value, it will be defaulted to the heartbeat time out
  // Currently set to 15 seconds
  _maxDowntime: 15000
```

### Release Downloads 

A number of changes were made to add release downloads to ampm. See [this commit](https://github.com/local-projects/ampm/commit/8bb1da92a99770358d11f4b63eda63a7ef36b7ab) for most of the changes. For this update, a new model was created ```downloads.js```. 

To add release downloads from github, the following should be added to ```ampm.json```

```json
		"downloads": {
            // github organization name 
			"org": "local-projects",
            // repo name
			"repo": "fldc.beacons.unity",
            // the folder that the release should be saved at, all downloads default to 			c:\\localprojects
			"appName": "BEACONS",
            // script that downloads the release, this is in the ampm scripts folder
			"releaseScript": "C:\\localprojects\\ampm\\scripts\\download-release.bat"
		}
```

The ```download-release.bat``` script requires a GitHub token that should be saved at ```c:\\.creds``` as ```github_token.txt```. 



### Steps to download release for deployed software on a PC

It is recommended to kill explorer for released applications to avoid popups or finding the desktop. If this is the case, below are the steps to reach the download release button. 

1. Force the application out of fullscreen mode (usually `f` or `w` to cycle between screen modes in ```ofxScreenSetup``` ).
2. ctrl + alt + delete to bring up the task manager
3. Click ```file >> run new task```
4. Enter ```explorer``` which will bring the desktop back. 
5. Open a web browser and  go to the configured ampm client. Default is localhost:8888
6. Click the ```Download Release``` link / button. This will automatically kill the application, download the new release, and relaunch the application. It is recommended to reboot the system once this is complete. 



## UI CHANGES

* Download release button was added under Application
* Added ```downtime``` and  ```last heartbeat``` to the Dashboard

