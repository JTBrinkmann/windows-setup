# from https://www.reddit.com/r/PowerShell/comments/9ulosc/install_multiple_fonts_including_overwrite_or/e95n3cm/
Add-Type -AssemblyName System.Drawing
$FontCollection = [System.Drawing.Text.PrivateFontCollection]::new()    

$args | foreach {
	$fonts = Get-ChildItem -Path $_ -Include *.ttf -Recurse -File  # , *.otf
	echo "Installing $($fonts.count) fonts…"
	$i = 1
	foreach ($font in $fonts) {
		echo "[$i/$($fonts.count)] $($font.Basename)"
		$i++
		$sysfont = "C:\Windows\Fonts\$($font.Name)"
		if (Test-Path $sysfont) {
			Remove-Item -Fo -Path $sysfont
		}
		Copy-Item -Path $font -Destination $sysfont -Force -Confirm:$false -PassThru > $null

		$FontCollection.AddFontFile($font)

		$RegistryValue = @{
			Path = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts'
			Name = $FontCollection.Families[-1].Name
			Value = $font.Fullname
		}

		New-ItemProperty -Fo @RegistryValue > $null
	}
}