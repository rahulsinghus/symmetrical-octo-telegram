If (-Not (Get-Module -ListAvailable -Name 'PolicyFileEditor')){
    Install-Module -Name PolicyFileEditor -force
} 
Import-Module -Name PolicyFileEditor
$Entries = New-Object psobject -Property @{ ValueName = "UseWUServer"; Data = 0}
$Entries | set-PolicyFileEntry -Key SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU -Path $env:SystemRoot\system32\GroupPolicy\Machine\registry.pol -Type DWORD

gpupdate.exe /force
exit 0

