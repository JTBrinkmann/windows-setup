$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$isAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (!$isAdmin) {
    $ENV:isAdmin = ""
	echo "This script must be run as administrator!"
	
	if (gcm "sudo" -ErrorAction SilentlyContinue) {
		$confirmation = Read-Host "Do you want to run the script with elevated privileges? [Y/n] "
		if ($confirmation -ne 'n') {
			sudo $MyInvocation.PSCommandPath
			exit 0
		}
	}
	exit 1
} else {
    $ENV:isAdmin = $true
}
