$Path = "HKLM:\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Lockdown_Zones\3"
$Path1 = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"
$Name = "1A04"
$Type = "DWORD"
$Value = 0
New-ItemProperty -Path $Path -Name $Name -Type $Type -Value $Value -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path $Path -Name $Name -Type $Type -Value $Value -Force -ErrorAction SilentlyContinue
New-ItemProperty -Path $Path1 -Name $Name -Type $Type -Value $Value -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path $Path1 -Name $Name -Type $Type -Value $Value -Force -ErrorAction SilentlyContinue
exit 0