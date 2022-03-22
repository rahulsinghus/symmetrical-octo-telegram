$RegPath = "HKLM:\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Lockdown_Zones\3"
$RegPath1 = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"
$Name = "1A04"
$Value = 0

if ((Test-Path  ($RegPath)) -and (Test-Path ($RegPath1))) 
{
    If ((Get-ItemProperty -Path $RegPath -Name $Name).$Name -eq $Value){
        if ((Get-ItemProperty -Path $RegPath1 -Name $Name).$Name -eq $Value) {
            Write-Host "Compliant"
            Exit 0
        }else {
            write-Host "Non-Compliant"
            Exit 1            
        }
    }Else{
        write-Host "Non-Compliant"
        Exit 1
    }
}
Else{
    write-Host "Non-Compliant"
    Exit 1
}