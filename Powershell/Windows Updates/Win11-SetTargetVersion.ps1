$RP1 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"

set-ItemProperty -path $RP1 -Name "TargetReleaseVersion" -Type DWORD -Value 1 -Force

set-ItemProperty -path $RP1 -Name "TargetReleaseVersionInfo" -Type STRING -Value $ReleaseID.ReleaseID -Force
Exit 0