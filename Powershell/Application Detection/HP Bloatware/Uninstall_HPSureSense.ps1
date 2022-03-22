# HP Client Security Manager
if ((Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name like '%HP Client Security Manager%'")) {
    write-host "HP Client Security Manager Installed"
    (Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name like '%HP Client Security Manager%'").uninstall()
}else {
    write-host "HP Client Security Manager Not Installed"
}
# HP Sure Sense Installer
if ((Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name like '%HP Sure Sense Installer%'")) {
    write-host "HP Sure Sense Installer Installed"
    (Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name like '%HP Sure Sense Installer%'").uninstall()
}else {
    write-host "HP Sure Sense Installer Not Installed"
}
# HP Sure Click 
if ((Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name like '%HP Sure Click%'")) {
    write-host "HP Sure Click Installed"
    (Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name like '%HP Sure Click%'").uninstall()
}else {
    write-host "HP Sure Click Not Installed"
}