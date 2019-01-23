# Windows Setup
This script will automatically set up a Windows profile to my personal, opinionated taste.

## Standard Installation
### Apps
The following apps will be installed
**GUI:**
- [7zip](https://www.7-zip.org/)
- [notepad2-mod](https://github.com/XhmikosR/notepad2-mod)
- [firefox](https://www.mozilla.org/en-US/firefox/new/)

**console:** 
- [git](https://git-for-windows.github.io/)
- [pshazz](https://github.com/lukesampson/pshazz)
- [concfg](https://github.com/lukesampson/concfg)

### Settings
- notepad is replaced by Notepad2-mod
- all "user folders" (Pictures, Videos, …) are removed from the file explorer's sidebar (under This PC)
- the taskbar is configured (note: explorer is automatically restarted for this to take effect, all open folders will be closed!)
  - windows are shown only on the taskbar of the monitor they are opened on
  - windows are not grouped as long as there is enough space
- the font Source Code Pro is installed
- Firefox is configured (mostly to enhance privacy protection, however Mozilla telemetry gets enabled)
- the Powershell Console is configured
  - [Solarized Dark](https://github.com/lukesampson/concfg/blob/master/preset_examples/README.md#solarized-dark) Theme (via concfg)
  - xpander prompt (via pshazz)
    - modified to abbreviate the current path (e.g. `~\A\R\Mozilla` instead of `C:\Users\username\AppData\Roaming\Mozilla`)
  - font changed to Source Code Pro (to enable Powerline)

![prompt-preview](C:\Users\jan.brinkmann\Desktop\setup\prompt-preview.png)



## Extras

Optionally, by running `_extras.ps1`, more apps can be installed (and configured).

### Apps
**GUI:**

- [cmder](http://cmder.net)
- [Gimp](https://www.gimp.org/)
- [Gitkraken](https://www.gitkraken.com/)
- [jetbrains-toolbox](https://jetbrains.com/) (can be used to install Jetbrain's IDEs, e.g. IntelliJ)
- [Mattermost](https://mattermost.com/download/#mobile) Desktop client
- [QTTabBar](http://qttabbar.wikidot.com/)
- [ResophNotes](https://resoph.com/ResophNotes/Welcome.html)
- [ShareX](https://getsharex.com/)
- [SQLite Database Browser](https://sqlitebrowser.org/)
- [Thunderbird](https://www.mozilla.org/thunderbird/)
- [Typora](https://typora.io)
- [Unchecky](https://unchecky.com/)
- [Unlocker](http://www.emptyloop.com/unlocker/welcome.htm)
- [VLC](https://www.videolan.org/)

**console:** 

- [chocolatey](https://www.chocolatey.org/)
- [bat](https://github.com/sharkdp/bat)
- [caddy](https://caddyserver.com)
- [dos2unix](http://dos2unix.sourceforge.net/)
- [ffmpeg](https://ffmpeg.zeranoe.com/builds/)
- [imagemagick](https://www.imagemagick.org/script/index.php)
- [jq](https://stedolan.github.io/jq/)
- [less](http://www.greenwoodsoftware.com/less/)
- [nodejs](https://nodejs.org)
- [php](http://windows.php.net)
- [python](https://www.python.org/)
- [sed](http://gnuwin32.sourceforge.net/packages/sed.htm)
- [sudo](https://github.com/lukesampson/psutils)

### Settings
- `adb`, `fastboot`, etc is added to the PATH variable
- Unlocker is added to the context menu