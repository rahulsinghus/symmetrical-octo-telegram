$IPNodes = Get-Content C:\temp\xxx.txt

foreach ($IP in $IPNodes){
        if (Test-Connection -IPAddress $IP -Count 1 -Quiet)
    {
        "$IP is UP";
    } Else {
    "$IP is Down";
    }
}
