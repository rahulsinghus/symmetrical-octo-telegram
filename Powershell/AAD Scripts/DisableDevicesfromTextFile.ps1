$list = Get-Content ''
$date = Get-Date
$list | ForEach-Object {
    $devices = Get-AzureADDevice -SearchString $_
    foreach($device in $devices){
        $days = New-TimeSpan -Start $device.ApproximateLastLogonTimeStamp -End $date.DateTime
        if ($days.Days -ge 90) {
            Write-Host $device.DisplayName $device.ApproximateLastLogonTimeStamp $days.Days
            Set-AzureADDevice -ObjectId $device.ObjectId -AccountEnabled $false
        }
    }
}