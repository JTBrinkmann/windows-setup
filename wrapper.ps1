[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
iwr https://github.com/JTBrinkmann/windows-setup/archive/master.zip -O .\setup.zip
$shell = new-object -com shell.application
Expand-Archive .\setup.zip .
start -verb runas powershell "-noprofile -c $PWD\windows-setup-master\setup.ps1; pause"
