# configure taskbar
reg.exe import .\TaskbandCU.reg
kill -ProcessName explorer -Force

# set up scoop
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')

# install basic tools & apps
scoop install 7z git  # needed for buckets
scoop bucket add extras
scoop install notepad2-mod firefox

# style powershell
scoop bucket add nerd-fonts
scoop install pshazz concfg SourceCodePro-NF
concfg clean
concfg import -n solarized-dark .\sourcecode-pro.json
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