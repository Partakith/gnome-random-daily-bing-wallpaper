const Main = imports.ui.main;
const Me = imports.misc.extensionUtils.getCurrentExtension();
const GLib = imports.gi.GLib;

class BingWallpaperChanger {
    constructor() {
        this._init();
    }

    _init() {
        // Your initialization code here
    }

    changeWallpaper() {
        // Execute your wallpaper changing script
        let scriptPath = Me.dir.get_path() + '/set_wallpaper.sh';
        let [success, stdout, stderr] = GLib.spawn_command_line_sync(`/bin/bash ${scriptPath}`);
        if (!success) {
            log(`Error executing script: ${stderr}`);
        } else {
            log(`Script output: ${stdout}`);
        }
    }

    // Other methods here
}

let bingWallpaperChanger;

function init() {
    bingWallpaperChanger = new BingWallpaperChanger();
}

function enable() {
    bingWallpaperChanger.changeWallpaper(); // Call the changeWallpaper method when enabling the extension
}

function disable() {
    // Nothing to do on disable
}