<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> da81ee31987b6024a65b92773454730c15edf171
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
#Check for Windows Updates
New-Item -ItemType Directory -Force -Path "C:\Windows\Logs\PPD\Windows_Updates" | Out-Null;
$LogFile = ("C:\Windows\Logs\PPD\Windows_Updates\Windows_Updates.log");
$RegPath = "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate"
Function Write-Log{
    [CmdletBinding()]
    
    Param
    (
        [parameter(Mandatory=$true)][string]$File,
        [parameter(Mandatory=$true)][string]$Text,
        [parameter(Mandatory=$true)][string][ValidateSet("Information", "Error", "Warning")]$Status
    )

    
    $Output = ("[Informational][" + (((Get-Date).ToShortDateString()) + "][" + (Get-Date).ToLongTimeString()) + "][" + $Status + "] " + $Text);
    
    $Output | Out-File -Encoding UTF8 -Force -FilePath $File -Append;
    Return Write-Output $Output;
}
<<<<<<< HEAD

$arch = Get-WMIObject -Class Win32_Processor -ComputerName LocalHost | Select-Object AddressWidth
Write-Log -File $LogFile -Status Information -Text "Stopping Windows Update Services...";
Stop-Service -Name BITS -Force
Stop-Service -Name wuauserv -Force
Start-Sleep -Seconds 10
do {
    taskkill /f /fi "SERVICES eq wuauserv"
    $status = Get-Service -Name wuauserv
} while ($status.Status -eq "Running" -or $status.Status -eq "Stopping")
Stop-Service -Name appidsvc -Force
Stop-Service -Name cryptsvc -ErrorAction Ignore
Write-Log -File $LogFile -Status Information -Text "Remove QMGR Data file...";
Remove-Item "$env:allusersprofile\Application Data\Microsoft\Network\Downloader\qmgr*.dat" -ErrorAction SilentlyContinue
Write-Log -File $LogFile -Status Information -Text "Renaming the Software Distribution and CatRoot Folder...";
Rename-Item $env:systemroot\SoftwareDistribution SoftwareDistribution.bak -ErrorAction SilentlyContinue
Rename-Item $env:systemroot\System32\Catroot2 catroot2.bak -ErrorAction SilentlyContinue
Write-Log -File $LogFile -Status Information -Text "Removing old Windows Update log...";
Remove-Item $env:systemroot\WindowsUpdate.log -ErrorAction SilentlyContinue
Write-Log -File $LogFile -Status Information -Text "Resetting the Windows Update Services to defualt settings...";
Write-Log -File $LogFile -Status Information -Text "sc.exe sdset bits D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)";
Write-Log -File $LogFile -Status Information -Text "sc.exe sdset wuauserv D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)";
Set-Location $env:systemroot\system32
Write-Log -File $LogFile -Status Information -Text "Registering some DLLs...";
regsvr32.exe /s atl.dll
regsvr32.exe /s urlmon.dll
regsvr32.exe /s mshtml.dll
regsvr32.exe /s shdocvw.dll
regsvr32.exe /s browseui.dll
regsvr32.exe /s jscript.dll
regsvr32.exe /s vbscript.dll
regsvr32.exe /s scrrun.dll
regsvr32.exe /s msxml.dll
regsvr32.exe /s msxml3.dll
regsvr32.exe /s msxml6.dll
regsvr32.exe /s actxprxy.dll
regsvr32.exe /s softpub.dll
regsvr32.exe /s wintrust.dll
regsvr32.exe /s dssenh.dll
regsvr32.exe /s rsaenh.dll
regsvr32.exe /s gpkcsp.dll
regsvr32.exe /s sccbase.dll
regsvr32.exe /s slbcsp.dll
regsvr32.exe /s cryptdlg.dll
regsvr32.exe /s oleaut32.dll
regsvr32.exe /s ole32.dll
regsvr32.exe /s shell32.dll
regsvr32.exe /s initpki.dll
regsvr32.exe /s wuapi.dll
regsvr32.exe /s wuaueng.dll
regsvr32.exe /s wuaueng1.dll
regsvr32.exe /s wucltui.dll
regsvr32.exe /s wups.dll
regsvr32.exe /s wups2.dll
regsvr32.exe /s wuweb.dll
regsvr32.exe /s qmgr.dll
regsvr32.exe /s qmgrprxy.dll
regsvr32.exe /s wucltux.dll
regsvr32.exe /s muweb.dll
regsvr32.exe /s wuwebv.dll
Write-Log -File $LogFile -Status Information -Text "Removing WSUS client settings...";
try {
    #Get-Item -Path HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate | Remove-ItemProperty -Name AccountDomainSid
    Remove-ItemProperty -path $RegPath -Name "AccountDomainSid" -force -ErrorAction Ignore
    #& cmd /c 'REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v AccountDomainSid /f' > $null
}
catch {
    Write-Log -File $LogFile -Status Information -Text "AccountDomainSid - regkey deletion failed.";
}
try {
    #Get-Item -Path HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate | Remove-ItemProperty -Name PingID
    Remove-ItemProperty -path $RegPath -Name "PingID" -force -ErrorAction Ignore
    #& cmd /c 'REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v PingID /f' > $null
}
catch {
    Write-Log -File $LogFile -Status Information -Text "PingID - regkey deletion failed.";
}
try {
    #Get-Item -Path HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate | Remove-ItemProperty -Name SusClientId
    Remove-ItemProperty -path $RegPath -Name "SusClientId" -force -ErrorAction Ignore
    #& cmd /c 'REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientId /f' > $null
}
catch {
    Write-Log -File $LogFile -Status Information -Text "SusClientId - regkey deletion failed.";
}
Write-Log -File $LogFile -Status Information -Text "Resetting the WinSock...";
netsh winsock reset
netsh winhttp reset proxy
Write-Log -File $LogFile -Status Information -Text "Delete all BITS jobs...";
Get-BitsTransfer | Remove-BitsTransfer
Write-Log -File $LogFile -Status Information -Text "Starting Windows Update Services...";
Start-Service -Name BITS
Start-Service -Name wuauserv
Start-Service -Name appidsvc
Start-Service -Name cryptsvc
Write-Log -File $LogFile -Status Information -Text "Forcing discovery...";
# Check Windows Updates
wuauclt /resetauthorization /detectnow
Write-Log -File $LogFile -Status Information -Text "Process complete. Computer needs reboot.";

=======
try {
    $arch = Get-WMIObject -Class Win32_Processor -ComputerName LocalHost | Select-Object AddressWidth
    Write-Log -File $LogFile -Status Information -Text "Stopping Windows Update Services...";
    Stop-Service -Name BITS
    Stop-Service -Name wuauserv
    Stop-Service -Name appidsvc
    Stop-Service -Name cryptsvc -ErrorAction Ignore
    Write-Log -File $LogFile -Status Information -Text "Remove QMGR Data file...";
    Remove-Item "$env:allusersprofile\Application Data\Microsoft\Network\Downloader\qmgr*.dat" -ErrorAction SilentlyContinue
    Write-Log -File $LogFile -Status Information -Text "Renaming the Software Distribution and CatRoot Folder...";
    Rename-Item $env:systemroot\SoftwareDistribution SoftwareDistribution.bak -ErrorAction SilentlyContinue
    Rename-Item $env:systemroot\System32\Catroot2 catroot2.bak -ErrorAction SilentlyContinue
    Write-Log -File $LogFile -Status Information -Text "Removing old Windows Update log...";
    Remove-Item $env:systemroot\WindowsUpdate.log -ErrorAction SilentlyContinue
    Write-Log -File $LogFile -Status Information -Text "Resetting the Windows Update Services to defualt settings...";
    Write-Log -File $LogFile -Status Information -Text "sc.exe sdset bits D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)";
    Write-Log -File $LogFile -Status Information -Text "sc.exe sdset wuauserv D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)";
    Set-Location $env:systemroot\system32
    Write-Log -File $LogFile -Status Information -Text "Registering some DLLs...";
    regsvr32.exe /s atl.dll
    regsvr32.exe /s urlmon.dll
    regsvr32.exe /s mshtml.dll
    regsvr32.exe /s shdocvw.dll
    regsvr32.exe /s browseui.dll
    regsvr32.exe /s jscript.dll
    regsvr32.exe /s vbscript.dll
    regsvr32.exe /s scrrun.dll
    regsvr32.exe /s msxml.dll
    regsvr32.exe /s msxml3.dll
    regsvr32.exe /s msxml6.dll
    regsvr32.exe /s actxprxy.dll
    regsvr32.exe /s softpub.dll
    regsvr32.exe /s wintrust.dll
    regsvr32.exe /s dssenh.dll
    regsvr32.exe /s rsaenh.dll
    regsvr32.exe /s gpkcsp.dll
    regsvr32.exe /s sccbase.dll
    regsvr32.exe /s slbcsp.dll
    regsvr32.exe /s cryptdlg.dll
    regsvr32.exe /s oleaut32.dll
    regsvr32.exe /s ole32.dll
    regsvr32.exe /s shell32.dll
    regsvr32.exe /s initpki.dll
    regsvr32.exe /s wuapi.dll
    regsvr32.exe /s wuaueng.dll
    regsvr32.exe /s wuaueng1.dll
    regsvr32.exe /s wucltui.dll
    regsvr32.exe /s wups.dll
    regsvr32.exe /s wups2.dll
    regsvr32.exe /s wuweb.dll
    regsvr32.exe /s qmgr.dll
    regsvr32.exe /s qmgrprxy.dll
    regsvr32.exe /s wucltux.dll
    regsvr32.exe /s muweb.dll
    regsvr32.exe /s wuwebv.dll
    Write-Log -File $LogFile -Status Information -Text "Removing WSUS client settings...";
    try {
        #Get-Item -Path HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate | Remove-ItemProperty -Name AccountDomainSid
        Remove-ItemProperty -path $RegPath -Name "AccountDomainSid" -force -ErrorAction Ignore
        #& cmd /c 'REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v AccountDomainSid /f' > $null
    }
    catch {
        Write-Log -File $LogFile -Status Information -Text "AccountDomainSid - regkey deletion failed.";
    }
    try {
        #Get-Item -Path HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate | Remove-ItemProperty -Name PingID
        Remove-ItemProperty -path $RegPath -Name "PingID" -force -ErrorAction Ignore
        #& cmd /c 'REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v PingID /f' > $null
    }
    catch {
        Write-Log -File $LogFile -Status Information -Text "PingID - regkey deletion failed.";
    }
    try {
        #Get-Item -Path HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate | Remove-ItemProperty -Name SusClientId
        Remove-ItemProperty -path $RegPath -Name "SusClientId" -force -ErrorAction Ignore
        #& cmd /c 'REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientId /f' > $null
    }
    catch {
        Write-Log -File $LogFile -Status Information -Text "SusClientId - regkey deletion failed.";
    }
    Write-Log -File $LogFile -Status Information -Text "Resetting the WinSock...";
    netsh winsock reset
    netsh winhttp reset proxy
    Write-Log -File $LogFile -Status Information -Text "Delete all BITS jobs...";
    Get-BitsTransfer | Remove-BitsTransfer
    Write-Log -File $LogFile -Status Information -Text "Attempting to install the Windows Update Agent...";
    if($arch -eq 64){
        wusa Windows8-RT-KB2937636-x64 /quiet
    }
    else{
        wusa Windows8-RT-KB2937636-x86 /quiet
    }
    Write-Log -File $LogFile -Status Information -Text "Starting Windows Update Services...";
    Start-Service -Name BITS
    Start-Service -Name wuauserv
    Start-Service -Name appidsvc
    Start-Service -Name cryptsvc
    Write-Log -File $LogFile -Status Information -Text "Forcing discovery...";
    # Check Windows Updates
    wuauclt /resetauthorization /detectnow
    Write-Log -File $LogFile -Status Information -Text "Process complete. Computer needs reboot.";
}
catch {
    Write-Host "Errors during WU Reset"
}
=======
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
#Check for Windows Updates
New-Item -ItemType Directory -Force -Path "C:\Windows\Logs\PPD\Windows_Updates" | Out-Null;
$LogFile = ("C:\Windows\Logs\PPD\Windows_Updates\Windows_Updates.log");
$RegPath = "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate"
Function Write-Log{
    [CmdletBinding()]
    
    Param
    (
        [parameter(Mandatory=$true)][string]$File,
        [parameter(Mandatory=$true)][string]$Text,
        [parameter(Mandatory=$true)][string][ValidateSet("Information", "Error", "Warning")]$Status
    )

    
    $Output = ("[Informational][" + (((Get-Date).ToShortDateString()) + "][" + (Get-Date).ToLongTimeString()) + "][" + $Status + "] " + $Text);
    
    $Output | Out-File -Encoding UTF8 -Force -FilePath $File -Append;
    Return Write-Output $Output;
}

$arch = Get-WMIObject -Class Win32_Processor -ComputerName LocalHost | Select-Object AddressWidth
Write-Log -File $LogFile -Status Information -Text "Stopping Windows Update Services...";
Stop-Service -Name BITS -Force
Stop-Service -Name wuauserv -Force
Start-Sleep -Seconds 10
do {
    taskkill /f /fi "SERVICES eq wuauserv"
    $status = Get-Service -Name wuauserv
} while ($status.Status -eq "Running" -or $status.Status -eq "Stopping")
Stop-Service -Name appidsvc -Force
Stop-Service -Name cryptsvc -ErrorAction Ignore
Write-Log -File $LogFile -Status Information -Text "Remove QMGR Data file...";
Remove-Item "$env:allusersprofile\Application Data\Microsoft\Network\Downloader\qmgr*.dat" -ErrorAction SilentlyContinue
Write-Log -File $LogFile -Status Information -Text "Renaming the Software Distribution and CatRoot Folder...";
Rename-Item $env:systemroot\SoftwareDistribution SoftwareDistribution.bak -ErrorAction SilentlyContinue
Rename-Item $env:systemroot\System32\Catroot2 catroot2.bak -ErrorAction SilentlyContinue
Write-Log -File $LogFile -Status Information -Text "Removing old Windows Update log...";
Remove-Item $env:systemroot\WindowsUpdate.log -ErrorAction SilentlyContinue
Write-Log -File $LogFile -Status Information -Text "Resetting the Windows Update Services to defualt settings...";
Write-Log -File $LogFile -Status Information -Text "sc.exe sdset bits D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)";
Write-Log -File $LogFile -Status Information -Text "sc.exe sdset wuauserv D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)";
Set-Location $env:systemroot\system32
Write-Log -File $LogFile -Status Information -Text "Registering some DLLs...";
regsvr32.exe /s atl.dll
regsvr32.exe /s urlmon.dll
regsvr32.exe /s mshtml.dll
regsvr32.exe /s shdocvw.dll
regsvr32.exe /s browseui.dll
regsvr32.exe /s jscript.dll
regsvr32.exe /s vbscript.dll
regsvr32.exe /s scrrun.dll
regsvr32.exe /s msxml.dll
regsvr32.exe /s msxml3.dll
regsvr32.exe /s msxml6.dll
regsvr32.exe /s actxprxy.dll
regsvr32.exe /s softpub.dll
regsvr32.exe /s wintrust.dll
regsvr32.exe /s dssenh.dll
regsvr32.exe /s rsaenh.dll
regsvr32.exe /s gpkcsp.dll
regsvr32.exe /s sccbase.dll
regsvr32.exe /s slbcsp.dll
regsvr32.exe /s cryptdlg.dll
regsvr32.exe /s oleaut32.dll
regsvr32.exe /s ole32.dll
regsvr32.exe /s shell32.dll
regsvr32.exe /s initpki.dll
regsvr32.exe /s wuapi.dll
regsvr32.exe /s wuaueng.dll
regsvr32.exe /s wuaueng1.dll
regsvr32.exe /s wucltui.dll
regsvr32.exe /s wups.dll
regsvr32.exe /s wups2.dll
regsvr32.exe /s wuweb.dll
regsvr32.exe /s qmgr.dll
regsvr32.exe /s qmgrprxy.dll
regsvr32.exe /s wucltux.dll
regsvr32.exe /s muweb.dll
regsvr32.exe /s wuwebv.dll
Write-Log -File $LogFile -Status Information -Text "Removing WSUS client settings...";
try {
    #Get-Item -Path HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate | Remove-ItemProperty -Name AccountDomainSid
    Remove-ItemProperty -path $RegPath -Name "AccountDomainSid" -force -ErrorAction Ignore
    #& cmd /c 'REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v AccountDomainSid /f' > $null
}
catch {
    Write-Log -File $LogFile -Status Information -Text "AccountDomainSid - regkey deletion failed.";
}
try {
    #Get-Item -Path HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate | Remove-ItemProperty -Name PingID
    Remove-ItemProperty -path $RegPath -Name "PingID" -force -ErrorAction Ignore
    #& cmd /c 'REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v PingID /f' > $null
}
catch {
    Write-Log -File $LogFile -Status Information -Text "PingID - regkey deletion failed.";
}
try {
    #Get-Item -Path HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate | Remove-ItemProperty -Name SusClientId
    Remove-ItemProperty -path $RegPath -Name "SusClientId" -force -ErrorAction Ignore
    #& cmd /c 'REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientId /f' > $null
}
catch {
    Write-Log -File $LogFile -Status Information -Text "SusClientId - regkey deletion failed.";
}
Write-Log -File $LogFile -Status Information -Text "Resetting the WinSock...";
netsh winsock reset
netsh winhttp reset proxy
Write-Log -File $LogFile -Status Information -Text "Delete all BITS jobs...";
Get-BitsTransfer | Remove-BitsTransfer
Write-Log -File $LogFile -Status Information -Text "Starting Windows Update Services...";
Start-Service -Name BITS
Start-Service -Name wuauserv
Start-Service -Name appidsvc
Start-Service -Name cryptsvc
Write-Log -File $LogFile -Status Information -Text "Forcing discovery...";
# Check Windows Updates
wuauclt /resetauthorization /detectnow
Write-Log -File $LogFile -Status Information -Text "Process complete. Computer needs reboot.";

>>>>>>> b6f1535f41b97b77996b752ff7e1eb5ffa78f68f
>>>>>>> da81ee31987b6024a65b92773454730c15edf171
exit 0