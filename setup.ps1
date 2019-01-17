if(($PSVersionTable.PSVersion.Major) -lt [System.Version]"5.1") {
	echo "This script requires Powershell 5.1"
	echo "currently running $($PSVersionTable.PSVersion)"
    echo "Upgrade PowerShell: https://docs.microsoft.com/en-us/powershell/scripting/setup/installing-windows-powershell"
    exit 1
}

$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$isAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (!$isAdmin) {
	echo "This script must be run as administrator!"
	
	if (gcm "sudo" -ErrorAction SilentlyContinue) {
		$confirmation = Read-Host "Do you want to run the script with elevated privileges? [Y/n] "
		if ($confirmation -ne 'n') {
		  sudo $MyInvocation.MyCommand.Source
			exit 0
		}
	}
	exit 1
}

Set-ExecutionPolicy Bypass -scope CurrentUser

# fix downloading over HTTPS
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
$net = (New-Object System.Net.WebClient)

# import registry changes
ls -r reg *.reg | foreach { reg import $_.FullName }

# restart explorer, to apply changes made in registry
kill -ProcessName explorer -Force

# install basic tools & apps
scoop install 7z git  # needed for buckets
scoop bucket add extras
scoop install notepad2-mod firefox pshazz concfg

# replace notepad with notepad2-mod
$notepad2_path = join-path (gcm notepad2.ps1 | gi).DirectoryName "..\apps\notepad2-mod\current\Notepad2.exe"
$notepad_reg_key = "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe"
sudo reg add $notepad_reg_key /v "Debugger" /t REG_SZ /d "`"$notepad2_path`" /z" /f

# install SourceCode Pro (SauceCode-Pro-NF via scoop-nerd-fonts can't be applied to console)
mkdir .\tmp
pushd .\tmp
iwr "https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.zip" -O .\font.zip
7z e .\font.zip -ofont
sudo ..\lib\install-fonts.ps1 ".\font\"
popd .\tmp
#rmdir -R -Fo .\tmp

# style powershell
## use concfg to set the color scheme to use solarized-dark with Source-Code Pro font and long backlog
concfg clean
concfg import -n solarized-dark .\configs\source-code-pro-semibold.json
concfg tokencolor disable

## prompt_pwd plugin to show short path names,
## e.g. "~\A\R\Mozilla" instead of C:\Users\username\AppData\Roaming\Mozilla
$pshazzdir = "$((get-item (pshazz which default)).DirectoryName)\.."
copy .\lib\prompt_pwd.ps1 $pshazzdir\plugins\


## customize prompt (use xpander but with prompt_pwd and start command in next line)
## (also remove plugins for hg and ssh for faster loadtime)
(cat "$pshazzdir\themes\xpander.json" `
	).replace('"hg", "ssh"', '"prompt_pwd"' `
	).replace('" $"', '"`n$([char]0x3BB)"' `
	) > "$pshazzdir\themes\xpander-lambda.json"
	# ).replace('["", "", " $"]', '["White", "Blue", "`n$([char]0x3BB)"],["Blue", "Black", "$rightarrow"]' `
pshazz use xpander-lambda

# configure firefox
kill -ProcessName firefox -Force
$ffprofiles = "$ENV:appdata\Mozilla\Firefox\Profiles"
ls $ffprofiles | foreach {
	copy .\configs\firefox-user.js $ffprofiles\$_\user.js
}
firefox -setDefaultBrowser "https://accounts.firefox.com/signin?service=sync"
