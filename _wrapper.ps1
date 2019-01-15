[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iex (New-Object System.Net.WebClient).downloadstring('https://get.scoop.sh')
scoop install sudo 7zip

iwr https://gist.github.com/JTBrinkmann/f86d52fe8dd8e76331fa4050e5fcbcbc/archive/master.zip -O setup.zip
7z e .\setup.zip -osetup
sudo setup/setup.ps1
