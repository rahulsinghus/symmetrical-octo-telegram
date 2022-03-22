#connect-azuread
$List= Get-Content C:\Machines_SCCM_Issues.txt
$today = Get-Date
$List | ForEach-Object {
    $DeviceIDs = Get-AzureADDevice -SearchString $_
    foreach ($item in $DeviceIDs) {
        $device = Get-AzureADDevice -SearchString $item.DisplayName | Select-Object *
        try {
            $days = new-timespan -start $device.ApproximateLastLogonTimeStamp -end $today
            if ($days.Days -ge 90) {
                Write-Host $device.DisplayName $days.Days "Disabled"
                set-azureaddevice -ObjectId $device.ObjectId -AccountEnabled $false
            }
        }
        catch {

        }
    }
}