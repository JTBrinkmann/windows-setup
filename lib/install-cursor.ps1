WORK IN PROGRESS
exit 1

$RegConnect = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]"CurrentUser","$ENV:COMPUTERNAME")
$RegCursors = $RegConnect.OpenSubKey("Control Panel\Cursors",$true)

$RegCursors.SetValue("","Windows Black")
$RegCursors.SetValue("AppStarting","%SystemRoot%\cursors\wait_r.cur")
$RegCursors.SetValue("Arrow","%SystemRoot%\cursors\arrow_r.cur")
$RegCursors.SetValue("Crosshair","%SystemRoot%\cursors\cross_r.cur")
$RegCursors.SetValue("Hand","")
$RegCursors.SetValue("Help","%SystemRoot%\cursors\help_r.cur")
$RegCursors.SetValue("IBeam","%SystemRoot%\cursors\beam_r.cur")
$RegCursors.SetValue("No","%SystemRoot%\cursors\no_r.cur")
$RegCursors.SetValue("NWPen","%SystemRoot%\cursors\pen_r.cur")
$RegCursors.SetValue("SizeAll","%SystemRoot%\cursors\move_r.cur")
$RegCursors.SetValue("SizeNESW","%SystemRoot%\cursors\size1_r.cur")
$RegCursors.SetValue("SizeNS","%SystemRoot%\cursors\size4_r.cur")
$RegCursors.SetValue("SizeNWSE","%SystemRoot%\cursors\size2_r.cur")
$RegCursors.SetValue("SizeWE","%SystemRoot%\cursors\size3_r.cur")
$RegCursors.SetValue("UpArrow","%SystemRoot%\cursors\up_r.cur")
$RegCursors.SetValue("Wait","%SystemRoot%\cursors\busy_r.cur")

$RegCursors.Close()
$RegConnect.Close()


$CSharpSig = @'
[DllImport("user32.dll", EntryPoint = "SystemParametersInfo")]
public static extern bool SystemParametersInfo(uint uiAction, uint uiParam, uint pvParam, uint fWinIni);
'@
$CursorRefresh = Add-Type -MemberDefinition $CSharpSig -Name WinAPICall -Namespace SystemParamInfo –PassThru
$CursorRefresh::SystemParametersInfo(0x0057,0,$null,0)