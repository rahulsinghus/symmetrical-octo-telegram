$value = Get-ComputerInfo | Select-Object -Property OsVersion, WindowsInstallDateFromRegistry, BiosFirmwareType, BiosManufacturer, BiosName, BiosReleaseDate, BiosSeralNumber, CsCaption, CsSystemFamily, OsInstallDate, DeviceGuardSmartStatus
$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation"

$RegPath = "HKLM:\SOFTWARE\Microsoft\Provisioning\Diagnostics\Autopilot"
$Name = "CloudAssignedDeviceName"

if (test-path $RegPath) {
    if ((Get-ItemProperty -Path $RegPath -Name $Name).CloudAssignedDeviceName) {
        Write-Host "AutoPilot"
        ########OSVersion####################
        New-ItemProperty -Path $Path -Name "OSVersion" -Value $Value.OsVersion -Force -ErrorAction SilentlyContinue
        Set-ItemProperty -Path $Path -Name "OSVersion" -Value $Value.OsVersion -Force -ErrorAction SilentlyContinue
        ########WindowsInstallDateFromRegistry####################
        New-ItemProperty -Path $Path -Name "WindowsInstallDateFromRegistry" -Value $Value.WindowsInstallDateFromRegistry -Force -ErrorAction SilentlyContinue
        Set-ItemProperty -Path $Path -Name "WindowsInstallDateFromRegistry" -Value $Value.WindowsInstallDateFromRegistry -Force -ErrorAction SilentlyContinue
        ########BiosFirmwareType####################
        New-ItemProperty -Path $Path -Name "BiosFirmwareType" -Value $Value.BiosFirmwareType -Force -ErrorAction SilentlyContinue
        Set-ItemProperty -Path $Path -Name "BiosFirmwareType" -Value $Value.BiosFirmwareType -Force -ErrorAction SilentlyContinue
        ########BiosManufacturer####################
        New-ItemProperty -Path $Path -Name "BiosManufacturer" -Value $Value.BiosManufacturer -Force -ErrorAction SilentlyContinue
        Set-ItemProperty -Path $Path -Name "BiosManufacturer" -Value $Value.BiosManufacturer -Force -ErrorAction SilentlyContinue
        ########BiosName####################
        New-ItemProperty -Path $Path -Name "BiosName" -Value $Value.BiosName -Force -ErrorAction SilentlyContinue
        Set-ItemProperty -Path $Path -Name "BiosName" -Value $Value.BiosName -Force -ErrorAction SilentlyContinue
        ########BiosReleaseDate####################
        New-ItemProperty -Path $Path -Name "BiosReleaseDate" -Value $Value.BiosReleaseDate -Force -ErrorAction SilentlyContinue
        Set-ItemProperty -Path $Path -Name "BiosReleaseDate" -Value $Value.BiosReleaseDate -Force -ErrorAction SilentlyContinue
        ########BiosSeralNumber####################
        New-ItemProperty -Path $Path -Name "SerialNumber" -Value $Value.BiosSeralNumber -Force -ErrorAction SilentlyContinue
        Set-ItemProperty -Path $Path -Name "SerialNumber" -Value $Value.BiosSeralNumber -Force -ErrorAction SilentlyContinue
        ########CsCaption####################
        New-ItemProperty -Path $Path -Name "CsCaption" -Value $Value.CsCaption -Force -ErrorAction SilentlyContinue
        Set-ItemProperty -Path $Path -Name "CsCaption" -Value $Value.CsCaption -Force -ErrorAction SilentlyContinue
        ########CsSystemFamily####################
        New-ItemProperty -Path $Path -Name "CsSystemFamily" -Value $Value.CsSystemFamily -Force -ErrorAction SilentlyContinue
        Set-ItemProperty -Path $Path -Name "CsSystemFamily" -Value $Value.CsSystemFamily -Force -ErrorAction SilentlyContinue
        ########OsInstallDate####################
        New-ItemProperty -Path $Path -Name "OSInstallDate" -Value $Value.OsInstallDate -Force -ErrorAction SilentlyContinue
        Set-ItemProperty -Path $Path -Name "OSInstallDate" -Value $Value.OsInstallDate -Force -ErrorAction SilentlyContinue
        ########DeviceGuardSmartStatus####################
        New-ItemProperty -Path $Path -Name "DeviceGuardSmartStatus" -Value $Value.DeviceGuardSmartStatus -Force -ErrorAction SilentlyContinue
        Set-ItemProperty -Path $Path -Name "DeviceGuardSmartStatus" -Value $Value.DeviceGuardSmartStatus -Force -ErrorAction SilentlyContinue
    }else {
        Write-Host "OSD"
    }
}else {
    Write-Host "OSD"
}
Exit 0