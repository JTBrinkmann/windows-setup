echo "This script requires Powershell 5.1"
echo "currently running $($PSVersionTable.PSVersion)"

Set-ExecutionPolicy Bypass -scope CurrentUser

# fix downloading over HTTPS
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
$net = (New-Object System.Net.WebClient)

# configure taskbar
reg.exe import .\taskbar.reg
kill -ProcessName explorer -Force

# install basic tools & apps
scoop install git  # needed for buckets
scoop bucket add extras
scoop install notepad2-mod firefox

# replace notepad with notepad2-mod
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe" /v "Debugger" /t REG_SZ /d "`"$((gcm notepad2.exe).Path)`" /z" /f

# install SourceCode Pro (SauceCode-Pro-NF via scoop-nerd-fonts can't be applied to console)
iwr "https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.zip" -O font.zip
7z e .\font.zip -ofont
.\install-fonts.ps1 ".\font\"
rm font.zip

# style powershell
## theme
scoop install pshazz concfg
concfg clean
concfg import -n solarized-dark .\source-code-pro-semibold.json
concfg tokencolor disable

## prompt_pwd plugin to show short path names,
## e.g. "~\A\R\Mozilla" instead of C:\Users\username\AppData\Roaming\Mozilla
$pshazzdir = "$((get-item (pshazz which default)).DirectoryName)\.."
copy .\prompt_pwd.ps1 $pshazzdir\plugins\

## pshazz (prompt) theme
## we modify xpander to use prompt_pwd and not use ssh and hg (to speed up profile loading time)
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
	copy firefox-user.js $ffprofiles\$_\user.js
}
firefox -setDefaultBrowser "https://accounts.firefox.com/signin?service=sync&context=fx_desktop_v3&entrypoint=menupanel"