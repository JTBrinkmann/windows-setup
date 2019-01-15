echo "This script requires Powershell 5.1"
echo "currently running $($PSVersionTable.PSVersion)"

# fix downloading over HTTPS
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
$net = (New-Object System.Net.WebClient)

# configure taskbar
reg.exe import .\taskbar.reg
kill -ProcessName explorer -Force

# set up scoop
Set-ExecutionPolicy Bypass -scope CurrentUser
iex $net.downloadstring('https://get.scoop.sh')

# install basic tools & apps
scoop install 7z git  # needed for buckets
scoop bucket add extras
scoop install notepad2-mod firefox

# install SourceCode Pro
iwr "https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.zip" -O font.zip
7z e .\font.zip -ofont
.\install-fonts.ps1 ".\font\"
rm font.zip

# style powershell
scoop install pshazz concfg # SourceCodePro-NF
concfg clean
concfg import -n solarized-dark .\source-code-pro-semibold.json
concfg tokencolor disable

$pshazzdir = "$((get-item (pshazz which default)).DirectoryName)\.."
copy .\prompt_pwd.ps1 $pshazzdir\plugins\
(cat "$pshazzdir\themes\xpander.json" `
	).replace('"hg", "ssh"', '"prompt_pwd"' `
	).replace('" $"', '"`n$([char]0x3BB)"' `
	) > "$pshazzdir\themes\xpander-lambda.json"
	# ).replace('["", "", " $"]', '["White", "Blue", "`n$([char]0x3BB)"],["Blue", "Black", "$rightarrow"]' `
pshazz use xpander-lambda

# configure firefox
$ffprofiles = "$ENV:appdata\Mozilla\Firefox\Profiles"
ls $ffprofiles | foreach {
	copy firefox-prefs.js $ffprofiles\$_\user.js
}