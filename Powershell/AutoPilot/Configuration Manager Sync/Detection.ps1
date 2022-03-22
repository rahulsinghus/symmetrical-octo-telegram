#   Remove from Provisioning Mode
#   Data Discovery Record
#   Hardware Inventory
#   Machine Policy Assignments Request

$value = Get-Date -Format 'MM/dd/yyyy HH:mm:ss'
$RegPath = "HKLM:\Software\xxx\AutoPilot"
$RegPathProvision = "HKLM:\SOFTWARE\Microsoft\CCM\CcmExec"
$Name = "TriggerStarted"
$ProcessActive = Get-Process ccmexec -ErrorAction SilentlyContinue
if(($ProcessActive -eq $null) -and ((Get-Item -Path $RegPath).GetValue($Name) -eq $null))
{
    exit 0
}
else
{
    
    #Remove from Provisioning Mode
    New-ItemProperty -Path $RegPathProvision -Name "SystemTaskExcludes" -Value "" -PropertyType string -Force
    New-ItemProperty -Path $RegPathProvision -Name "ProvisioningMode" -Value "false" -PropertyType string -Force
    
    #Data Discovery Record
    Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000003}"
    Start-Sleep -seconds 120
    
    #Hardware Inventory
    Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000001}"
    Start-Sleep -seconds 120
    
    #Machine Policy Assignments Request
    Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000021}"
    Start-Sleep -seconds 120
    
    if (Test-Path ($RegPath))
        {}
        Else{
          New-Item -Path "HKLM:\Software\xxx" -Name "AutoPilot" -Force
        }
    New-ItemProperty -Path $RegPath -Name $Name -Value $value -PropertyType string -Force
    exit 1
}