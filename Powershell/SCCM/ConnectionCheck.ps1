$ConnectionType=(Get-CimInstance -Namespace "Root/CCM" -ClassName ClientInfo).InInternet
If ($ConnectionType -match "False")
{Write-host "INTRANET"}
Else
{Write-host "INTERNET"}