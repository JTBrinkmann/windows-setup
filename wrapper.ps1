[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iex (New-Object System.Net.WebClient).downloadstring('https://get.scoop.sh')
scoop install sudo 7zip

iwr https://github.com/JTBrinkmann/windows-setup/archive/master.zip -O setup.zip
7z e .\setup.zip -osetup
sudo setup/setup.ps1
