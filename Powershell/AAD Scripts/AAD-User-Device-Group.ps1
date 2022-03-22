$list = Get-Content ""
$GroupID = ""
$list | ForEach-Object{
    $userid = Get-AzureADUser -SearchString $_
    $devicenames = Get-AzureADUserOwnedDevice -ObjectId $userid.ObjectId
    foreach ($device in $devicenames) {
        if ($device.DeviceOSType -eq "Windows") {
            Write-Host $device.DisplayName $_
            Add-AzureADGroupMember -ObjectId $GroupID -RefObjectId $device.ObjectId
        }
    }
}