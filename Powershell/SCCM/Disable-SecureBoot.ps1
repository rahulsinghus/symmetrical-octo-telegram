#Does Not Work, Do Not Use!

$SecureBootSetting = Confirm-SecureBootUEFI
if ($SecureBootSetting) {
    Write-Host $SecureBootSetting
    $manufactorer = Get-CimInstance -ClassName Win32_ComputerSystem
    if ($manufactorer.Manufacturer -like "Lenovo") {
        Write-Host $manufactorer.Manufacturer
        #Suspend Bitlocker
        Suspend-BitLocker -MountPoint "C:" -RebootCount 1
        #SecureBoot Lenovo
        (Get-WmiObject -class Lenovo_SetBiosSetting –namespace root\wmi).SetBiosSetting("SecureBoot,Disable")
        (Get-WmiObject -class Lenovo_SaveBiosSettings -namespace root\wmi).SaveBiosSettings()
    }elseif ($manufactorer.Manufacturer -like "HP") {
        #SecureBoot HP
        Set-HPEBIOS Secure Boot State 
    }
}else {
    Write-Host $SecureBootSetting
}
#save

(Get-WmiObject -Class Dell_SetBiosSetting -namespace root\wmi).SetBiosSetting("SecureBoot,Disable")