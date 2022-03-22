#Set Windows Update Auto
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
$Name = "NoAutoUpdate"
$Type = "DWORD"
$Value = 0
New-ItemProperty -Path $Path -Name $Name -Type $Type -Value $Value -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path $Path -Name $Name -Type $Type -Value $Value -Force -ErrorAction SilentlyContinue
#OS check
try {
    dism.exe /Online /Cleanup-image /Restorehealth /quiet
}
catch {
    Write-Host "Error During Dism"
}
#Reset WU Update Services
net stop wuauserv
Stop-Service -Name wuauserv -Force
Start-Sleep -Seconds 10
do {
    taskkill /f /fi "SERVICES eq wuauserv"
    $status = Get-Service -Name wuauserv
} while ($status.Status -eq "Running" -or $status.Status -eq "Stopping")
Remove-Item /s /q %systemroot%\SoftwareDistribution
net start wuauserv
net stop bits
net stop wuauserv
net stop cryptsvc
Remove-Item "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat"
Rename-Item "%Systemroot%\SoftwareDistribution\DataStore DataStore.bak"
Rename-Item "%Systemroot%\SoftwareDistribution\Download Download.bak"
Rename-Item "%Systemroot%\System32\catroot2 catroot2.bak"
cmd /c "sc.exe sdset bits D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)"
cmd /c "sc.exe sdset wuauserv D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)"
Set-Location /d %windir%\system32
regsvr32.exe atl.dll
regsvr32.exe urlmon.dll
regsvr32.exe mshtml.dll
regsvr32.exe shdocvw.dll
regsvr32.exe browseui.dll
regsvr32.exe jscript.dll
regsvr32.exe vbscript.dll
regsvr32.exe scrrun.dll
regsvr32.exe msxml.dll
regsvr32.exe msxml3.dll
regsvr32.exe msxml6.dll
regsvr32.exe actxprxy.dll
regsvr32.exe softpub.dll
regsvr32.exe wintrust.dll
regsvr32.exe dssenh.dll
regsvr32.exe rsaenh.dll
regsvr32.exe gpkcsp.dll
regsvr32.exe sccbase.dll
regsvr32.exe slbcsp.dll
regsvr32.exe cryptdlg.dll
regsvr32.exe oleaut32.dll
regsvr32.exe ole32.dll
regsvr32.exe shell32.dll
regsvr32.exe initpki.dll
regsvr32.exe wuapi.dll
regsvr32.exe wuaueng.dll
regsvr32.exe wuaueng1.dll
regsvr32.exe wucltui.dll
regsvr32.exe wups.dll
regsvr32.exe wups2.dll
regsvr32.exe wuweb.dll
regsvr32.exe qmgr.dll
regsvr32.exe qmgrprxy.dll
regsvr32.exe wucltux.dll
regsvr32.exe muweb.dll
regsvr32.exe wuwebv.dll
netsh winsock reset
net start bits
net start wuauserv
# Check Windows Updates
wuauclt /resetauthorization /detectnow
exit 0