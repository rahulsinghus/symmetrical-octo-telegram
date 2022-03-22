$reg = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
$key = "1"
$testkey = $null

$testkey = Get-ItemPropertyValue $reg -Name "UseWUServer" -ErrorAction SilentlyContinue
Write-Host $testkey

if($testkey -eq $key){
    Write-Host "Key Present"
    exit 1    
}else {
    Write-Host "Key Absent" 
   exit 0
}