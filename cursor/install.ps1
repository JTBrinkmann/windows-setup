pushd $PSScriptRoot
..\lib\require_admin.ps1
if (!$isAdmin) { popd; exit 1 }


echo "`ninstalling Obsidian cursor…"
rundll32 syssetup,SetupInfObjectInstallAction DefaultInstall 128 .\Obsidian.ini
sleep 5

echo "`nsetting Obsidian as current mouse pointer theme…"
reg import .\install.reg


echo "`nrefreshing cursor using system call…"
$CSharpSig = @'
[DllImport("user32.dll", EntryPoint = "SystemParametersInfo")]
public static extern bool SystemParametersInfo(uint uiAction, uint uiParam, uint pvParam, uint fWinIni);
'@
$CursorRefresh = Add-Type -MemberDefinition $CSharpSig -Name WinAPICall -Namespace SystemParamInfo –PassThru
$CursorRefresh::SystemParametersInfo(0x0057,0,$null,0)

echo "`ndone!"

popd