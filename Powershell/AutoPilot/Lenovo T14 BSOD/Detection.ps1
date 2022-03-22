$reg = "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AppID"
$key = "4"
try {
    $testkey = Get-ItemPropertyValue -ErrorAction SilentlyContinue -Path $reg -Name "Start"
}catch {

}
if(($testkey -eq $key) -and ($testkey.GetType().name -eq "Int32")){
    Write-Host "key present"
    exit 0
}else {
    Write-Host "key absent"
    exit 1
}