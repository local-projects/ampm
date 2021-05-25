# ampm OpenFrameworks sample

This is a bare-bones ampm template for an OpenFrameworks application on Windows 10. In order for it to work, you need to build or install an OF application on your system, then correct the paths in `run_app.bat` to reflect the path to its executable.

By default, OF on Windows produces two windows: a console and a GUI window. Depending on the method chosen in `run_app.bat`, the console may not be available or persistance features may not be available. To have both, your app needs to send heartbeats to ampm using [ofxHeartbeat]()

To run this sample, follow the usual usage instructions in the primary ampm README.