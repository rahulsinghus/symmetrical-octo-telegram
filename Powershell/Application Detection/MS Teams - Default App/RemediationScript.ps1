New-ItemProperty "HKCU:\SOFTWARE\IM Providers" -Name "DefaultIMApp" -Value "Teams" -PropertyType "String" -ErrorAction SilentlyContinue
Enable-NetAdapterBinding -Name "*" -ComponentID ms_tcpip6