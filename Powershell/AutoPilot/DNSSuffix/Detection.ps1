$reg = "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"
$key = ""
try {
    $testkey = Get-ItemPropertyValue -ErrorAction SilentlyContinue -Path $reg -Name "SearchList"
}catch {

}
if($testkey -eq $key){
    Write-Host "key present"
    exit 0
}else {
    Write-Host "key absent"
    exit 1
}