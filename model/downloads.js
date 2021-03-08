var child_process = require("child_process"); // http://nodejs.org/api/child_process.html
var _ = require("lodash"); // Utilities. http://underscorejs.org/
_.str = require("underscore.string");
var BaseModel = require("./baseModel.js").BaseModel;

// Startup and shutdown the app on demand and on schedule.
exports.Downloads = BaseModel.extend({
  defaults: {
    // github org of repo. eg local-projects
    org: "",

    // github org of repo. eg fldc.conversation-booth.fe
    repo: "",

    // directory you want the release saved as. eg.CONVERSATION_BOOTH
    appName: "",

    // point to bat script that downloads the latest release
    releaseScript: "",
  },

  _downloadingRelease: false,

  // Set up update loops.
  initialize: function () {
    BaseModel.prototype.initialize.apply(this);

    // Web apps will send them over the app socket.
    $$network.transports.socketToApp.sockets.on(
      "connection",
      _.bind(function (socket) {
        socket.on("downloadRelease", _.bind(this._onDownloadRelease, this));
      }, this)
    );
  },

  // Return state
  isDownloadingRelease: function () {
    return this._downloadingRelease;
  },

  // Handle app asking for new download
  _onDownloadRelease: function (message) {
    $$persistence.shutdownApp();
    this.downloadRelease();
  },

  // Donwload the latest release
  downloadRelease: function (force, callback) {
    console.log("Attempting to download-release");

    var bat = this.get("releaseScript");
    console.log(bat);
    var args = [this.get("org"), this.get("repo"), this.get("appName")];

    if (!bat.length) {
      console.error("There is no batch script to download the release!");
      return;
    }

    this._downloadingRelease = true;
    this.isDownloadingRelease();

    var downloadReleaseBat = child_process.spawn("cmd.exe", [
      "/c",
      bat,
      args[0],
      args[1],
      args[2],
    ]);

    downloadReleaseBat.stdout.on("data", (data) => {
      console.log(data.toString());
    });

    downloadReleaseBat.stderr.on("data", (data) => {
      console.error(data.toString());
    });

    downloadReleaseBat.on("exit", (code) => {
      console.log(`Child exited with code ${code}`);
      $$persistence.restartApp();
      this._downloadingRelease = false;
    });
  },
});
