$AADGroup = ""
$GroupID = ""
#$today = Get-Date
$AzureADGroup = Get-AzureADGroup -Filter "DisplayName eq '$AADGroup'" -All $true
$AzureADUsers = $AzureADGroup | Get-AzureADGroupMember -All $true
foreach ($item in $AzureADUsers) {
    #Write-Host $item.DisplayName
    $devices = Get-AzureADDevice -SearchString $item.DisplayName | Select-Object *
    foreach ($device in $devices) {
        if ($device.AccountEnabled -eq "True") {
            if (Test-Connection -ComputerName $device.DisplayName -Count 1 -Quiet){
                write-host $device.displayname " is UP"
                Add-AzureADGroupMember -ObjectId $GroupID -RefObjectId $device.objectid 
            }
        }
        #try {
        #    $days = new-timespan -start $device.ApproximateLastLogonTimeStamp -end $today
        #}
        #catch {
        #    
        #}
        #if ($days.Days -ge 90) {
        #    Write-Host $device.DisplayName $days.Days "Disabled"
        #    set-azureaddevice -ObjectId $device.ObjectId -AccountEnabled $false
        #}
        #if ($days.Days -lt 2) {
        #    Write-Host $device.DisplayName $days.Days "Checked in last 2 day"
        #}
    }
}
$AADGroupCount = $AzureADUsers | Measure-Object
Write-Host $AADGroup ": " $AADGroupCount.Count