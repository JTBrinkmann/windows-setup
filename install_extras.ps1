pushd $PSScriptRoot
.\lib\require_admin.ps1
if (!$ENV:isAdmin) { popd; echo "exit"; exit 1 }

# extra commandline utils
scoop install imagemagick python bat caddy cmder dos2unix ffmpeg jq php sed nodejs
npm install -g rebase-editor prettier spoof tldr fkill-cli

# install more programs using Pip
pip install --upgrade pip
pip install --upgrade youtube-dl

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
$unlocker_path = (gi "~\scoop\apps\unlocker\current").FullName -Replace '\\', "\\"
(gc .\reg_extras\unlocker.reg.template -raw) -replace '\$unlocker_path', "$unlocker_path" | Out-File -Encoding "UTF8" .\reg_extras\unlocker.reg
ls -r reg_extras *.reg | foreach { reg import $_.FullName }
rm reg_extras\unlocker.reg


# install more programs using Chocolatey
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation
choco install mattermost-desktop resophnotes qttabbar unchecky
popd