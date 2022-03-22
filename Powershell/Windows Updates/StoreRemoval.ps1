$release = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion")
if ((Get-AppxPackage -Name Microsoft.WindowsStore)-and($release.CurrentBuildNumber -le "19042")) {
    if (($release.CurrentBuildNumber -eq "19042")-and($release.UBR -lt "1165")) {
        Get-AppxPackage -Name Microsoft.WindowsStore | Remove-AppPackage -WhatIf
        Write-Host "Store Removed"
    }elseif ($release.CurrentBuildNumber -lt "19042") {
        Get-AppxPackage -Name Microsoft.WindowsStore | Remove-AppPackage -WhatIf
        write-host "Store Removed"
        else {
            write-host "Device " $release.currentbuildnumber $release.UBR "Does not need Store Moved"
        }
    }
    Write-Host "Microsoft Store Present"
}elseif ($release.CurrentBuildNumber -gt "19042") {
    write-host "OS Version Greater than 20H2"
}else {
    Write-Host "Store Not Present"
} 
if (($release.currentbuildnumber -ge "19042")-and($release.UBR -ge "1165")) {
    Write-Host "Build Version Greater than or Equal to  20H2"
    if ((Get-AppxPackage -Name Microsoft.WindowsStore)) {
        Write-Host "Store Present"
    }else {
        Write-Host "Re-installing Store"
        Get-AppxPackage microsoft.WindowsStore
    }
}