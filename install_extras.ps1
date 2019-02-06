pushd $PSScriptRoot
.\lib\require_admin.ps1
if (!$isAdmin) { popd; exit 1 }

# extra commandline utils
scoop install imagemagick python bat caddy cmder dos2unix ffmpeg jq php sed nodejs
npm install -g rebase-editor prettier spoof tldr fkill-cli

# set rebase-editor as git sequencer
git config --global sequence.editor rebase-editor

# extra GUI apps
scoop install jetbrains-toolbox gitkraken gimp atom sharex vlc autohotkey typora sqlitebrowser

# manually install whatever you need (e.g. Android Studio, IntelliJ, PHP-Storm)
jetbrains-toolbox

# add adb, fastboot, etc to path (installed with Android Studio, gets ignored if not installed)
$adbPath = "$ENV:LocalAppData\Android\Sdk\platform-tools"
[Environment]::SetEnvironmentVariable(
    "Path",
    "$([Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine));$adbPath",
    [EnvironmentVariableTarget]::Machine
)


# install Unlocker (portable) and add it to Explorer's context menu
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\Unlocker.exe" /ve /t REG_SZ /d "$unlocker_path\Unlocker.exe"
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UnlockerDriver5" /ve "ImagePath" /t REG_SZ /d "\??\$unlocker_path\UnlockerDriver5.sys"
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UnlockerDriver5" /ve "Type" /t REG_SZ /d dword:00000001
reg add "HKLM\SOFTWARE\Classes\AllFilesystemObjects\shellex\ContextMenuHandlers\UnlockerShellExtension" /ve /t REG_SZ /d "{DDE4BEEB-DDE6-48fd-8EB5-035C09923F83}"
reg add "HKLM\SOFTWARE\Classes\Folder\shellex\ContextMenuHandlers\UnlockerShellExtension" /ve /t REG_SZ /d "{DDE4BEEB-DDE6-48fd-8EB5-035C09923F83}"
reg add "HKLM\SOFTWARE\Classes\AllFilesystemObjects\shellex\ContextMenuHandlers\UnlockerShellExtension" /ve /t REG_SZ /d "{DDE4BEEB-DDE6-48fd-8EB5-035C09923F83}"
reg add "HKLM\SOFTWARE\Classes\Folder\shellex\ContextMenuHandlers\UnlockerShellExtension" /ve /t REG_SZ /d "{DDE4BEEB-DDE6-48fd-8EB5-035C09923F83}"



# install more programs using Chocolatey
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation
choco install mattermost-desktop resophnotes qttabbar unchecky
popd