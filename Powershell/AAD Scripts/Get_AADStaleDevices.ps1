$today = Get-Date
$list = Get-Content C:\temp\Machine.txt
$list | ForEach-Object {
    $devices = Get-AzureADDevice -SearchString "$_"
    foreach ($device in $devices) {
        Write-Host $device.DisplayName $device.ApproximateLastLogonTimeStamp $device.ObjectId
    }
}