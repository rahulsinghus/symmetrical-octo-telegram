$RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"
$Name = "1A04"
$Value = 0

if (Test-Path  ($RegPath)) 
{
    If ((Get-ItemProperty -Path $RegPath -Name $Name).$Name -eq $Value){
            Write-Host "Compliant"
            Exit 0
    }Else{
        write-Host "Non-Compliant"
        Exit 1
    }
}
Else{
    write-Host "Non-Compliant"
    Exit 1
}