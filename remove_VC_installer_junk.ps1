. $PSScriptRoot\lib\require_admin.ps1
if (!$ENV:isAdmin) { popd; echo "exit"; exit 1 }

ls -Path C:\* -File -Include globdata.ini, eula.*.txt, install.exe, install.ini, install.res.*.dll, VC_RED.cab, VC_RED.MSI, vcredist.bmp | foreach { echo "deleting $_"; rm -Fo $_ }
