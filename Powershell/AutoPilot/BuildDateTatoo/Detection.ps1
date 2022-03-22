$RegPath = "HKLM:\SOFTWARE\Microsoft\Provisioning\Diagnostics\Autopilot"
$Name = "CloudAssignedDeviceName"

if (test-path $RegPath) {
    if ((Get-ItemProperty -Path $RegPath -Name $Name).CloudAssignedDeviceName) {
        Write-Host "AutoPilot"
    }else {
        Write-Host "OSD"
    }
}else {
    Write-Host "OSD"
}