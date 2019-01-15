# extra commandline utils
scoop install imagemagick python python2 bat caddy cmder dos2unix ffmpeg jq php sed

# extra GUI apps
scoop install jetbrains-toolbox gitkraken gimp atom sharex vlc autohotkey

# manually install whatever you need (e.g. Android Studio, IntelliJ, PHP-Storm)
jetbrains-toolbox

# install more programs using Chocolatey
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation
choco install mattermost-desktop resophnotes qttabbar unchecky
