$AADGroup = ""
$AzureADGroup = Get-AzureADGroup -Filter "DisplayName eq '$AADGroup'" -All $true
$AzureADDevice = $AzureADGroup | Get-AzureADGroupMember -All $true
foreach ($item in $AzureADDevice) {
    $ddn = $item.DisplayName
    Get-IntuneManagedDevice -Filter "contains(deviceName,'$ddn')" | Invoke-IntuneManagedDeviceSyncDevice
    Write-Host $ddn "Sync Done"
}