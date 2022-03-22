$regkey = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power"
$ValueName = "HiberbootEnabled"
New-ItemProperty -Path $regkey -Name $ValueName -Value 0 -PropertyType "dword" -Force 
set-ItemProperty -Path $regkey -Name $ValueName -Value 0 -Force
exit 0
