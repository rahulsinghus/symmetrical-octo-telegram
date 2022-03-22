If (-Not (Get-Module -ListAvailable -Name 'PSWindowsUpdate')){
    Install-Module -Name PSWindowsUpdate -Force 
    Write-Host "PSWindowsUpdate was not installed. Installing module now."
} else{
    Write-Host "PSWindowsUpdate Already Installed"
}
try {
    Get-WindowsUpdate -Hide -KBArticleID "KB4577586" -AcceptAll
    Write-Host "KB4577586 Hidden"
}
catch {
    Write-Host "There was a problem hiding KB4577586"
}