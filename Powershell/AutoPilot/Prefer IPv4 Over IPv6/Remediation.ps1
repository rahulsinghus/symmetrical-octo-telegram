$reg = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"
$key = "32"
$testkey = $null
try {
    $testkey = Get-ItemPropertyValue $reg -Name "DisabledComponents"
    Write-Host $testkey
}catch {

}
if($testkey -eq $key){
    exit 0    
}else {
    
   exit 1
}