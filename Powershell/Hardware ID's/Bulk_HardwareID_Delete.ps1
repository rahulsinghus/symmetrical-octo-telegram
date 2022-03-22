#connect-msgraph
# Get all autopilot devices (even if more than 1000)
#$autopilotDevices = Invoke-MSGraphRequest -HttpMethod GET -Url "deviceManagement/windowsAutopilotDeviceIdentities" | Get-MSGraphAllPages
$counter = 0
$list = Get-Content C:\Temp\DeleteHWID_GroupTags.txt
$list | ForEach-Object{
    $counter++
    $device = Get-MgDevice -Filter "Deviceid eq '$($_)'"
    Write-Host $counter "Deleting " $device.DisplayName $device.ApproximateLastSignInDateTime $_
    $d = $device.PhysicalIds
    $d | ForEach-Object {
        if ($_ -ge "[ZTD") {
            $HWID = Invoke-MSGraphRequest -HttpMethod GET -Url "deviceManagement/windowsAutopilotDeviceIdentities/$($_.substring(8))"
            Invoke-MSGraphRequest -HttpMethod DELETE -Url "deviceManagement/windowsAutopilotDeviceIdentities/$($_.substring(8))"
            $HWID | Export-Csv -Path  C:\Temp\29_10_2021_StaleHWIDDeletion.csv -Append
        }
    }
}