$reg = "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"
$value = ""
New-ItemProperty -Path $reg -Name "SearchList" -Value $value -PropertyType "String" -Force 