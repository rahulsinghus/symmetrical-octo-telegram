$reg = "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AppID"
$value = "4"
New-ItemProperty -Path $reg -Name "Start" -Value $value -PropertyType "DWord" -Force 