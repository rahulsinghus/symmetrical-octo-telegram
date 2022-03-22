$iOSDevices = Get-AzureADDevice -All 1 -Filter "startswith(DeviceOSType,'iOS')" 

foreach ($iOSDevice in $iOSDevices) {
    $iOSUser = Get-AzureADDeviceRegisteredUser -ObjectId $iOSDevice.objectid
    Write-Host $iOSDevice.Displayname','$iOSDevice.AccountEnabled',' $iOSDevice.DeviceOSType',' $iOSDevice.DeviceOSVersion',' $iOSDevice.ApproximateLastLogonTimeStamp',' $iOSUser.Displayname',' $iOSUser.UserPrincipalName',' $iOSUser.Department',' $iOSUser.JobTitle',' $iOSUser.PhysicalDeliveryOfficeName 
    $deviceInfo = $iOSDevice.Displayname+','+$iOSDevice.AccountEnabled+','+ $iOSDevice.DeviceOSType+','+ $iOSDevice.DeviceOSVersion+','+ $iOSDevice.ApproximateLastLogonTimeStamp+','+ $iOSUser.Displayname+','+ $iOSUser.UserPrincipalName+','+ $iOSUser.Department+','+ $iOSUser.JobTitle+','+ $iOSUser.PhysicalDeliveryOfficeName 
    $deviceInfo | Out-File -FilePath C:\temp\iOSDevices.txt -Append
}