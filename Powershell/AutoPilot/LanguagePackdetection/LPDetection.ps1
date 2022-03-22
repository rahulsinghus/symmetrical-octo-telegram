$osinfo = Get-WmiObject -Class win32_operatingsystem
$languages = $osinfo.muilanguages
if($languages -notcontains 'en-US'){
    Write-output 'Language Pack Not installed!'
    
}else{
    Write-output 'Language Pack installed!'
    
}