$lastreboottime = Get-CimInstance -ClassName win32_operatingsystem | Select-Object lastbootuptime
$today = Get-Date
$days = New-TimeSpan -Start $lastreboottime.lastbootuptime -End $today
if ($days.Days -lt '3') {
    write-host $days.Days "Days since restart - (less than 3 days)"
    start-sleep -s 20
    #exit 0
}else {
    write-host $days.Days "Days since restart - (greater than 3 days)"
    #exit 1
    start-sleep -s 20
}