$reg = "HKCU:\SOFTWARE\IM Providers"
$key = "Teams"
$testkey = $null
try {
    $testkey = Get-ItemPropertyValue $reg -Name "DefaultIMApp"
    Write-Host $testkey
}catch {

}
if($testkey -eq $key){
    Write-Host "Key Present"
    #exit 0    
}else {
    Write-Host "Key Absent" 
   #exit 1
}