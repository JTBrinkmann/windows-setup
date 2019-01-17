# extra commandline utils
scoop install imagemagick python python2 bat caddy cmder dos2unix ffmpeg jq php sed

# extra GUI apps
scoop install jetbrains-toolbox gitkraken gimp atom sharex vlc autohotkey typora


# manually install whatever you need (e.g. Android Studio, IntelliJ, PHP-Storm)
jetbrains-toolbox

# install Unlocker (portable) and add it to Explorer's context menu
reg add "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\Unlocker.exe" /ve /t REG_SZ /d "$unlocker_path\Unlocker.exe"
reg add "HKLM:\SYSTEM\CurrentControlSet\Services\UnlockerDriver5" /ve "ImagePath" /t REG_SZ /d "\??\$unlocker_path\UnlockerDriver5.sys"
reg add "HKLM:\SYSTEM\CurrentControlSet\Services\UnlockerDriver5" /ve "Type" /t REG_SZ /d dword:00000001
reg add "HKLM:\SOFTWARE\Classes\AllFilesystemObjects\shellex\ContextMenuHandlers\UnlockerShellExtension" /ve /t REG_SZ /d "{DDE4BEEB-DDE6-48fd-8EB5-035C09923F83}"
reg add "HKLM:\SOFTWARE\Classes\Folder\shellex\ContextMenuHandlers\UnlockerShellExtension" /ve /t REG_SZ /d "{DDE4BEEB-DDE6-48fd-8EB5-035C09923F83}"
reg add "HKLM:\SOFTWARE\Classes\AllFilesystemObjects\shellex\ContextMenuHandlers\UnlockerShellExtension" /ve /t REG_SZ /d "{DDE4BEEB-DDE6-48fd-8EB5-035C09923F83}"
reg add "HKLM:\SOFTWARE\Classes\Folder\shellex\ContextMenuHandlers\UnlockerShellExtension" /ve /t REG_SZ /d "{DDE4BEEB-DDE6-48fd-8EB5-035C09923F83}"



# install more programs using Chocolatey
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation
choco install mattermost-desktop resophnotes qttabbar unchecky