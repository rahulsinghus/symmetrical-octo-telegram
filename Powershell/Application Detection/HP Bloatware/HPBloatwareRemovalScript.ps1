# HP Sure Run
if ((Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name like '%HP Sure Run%'")) {
    write-host "HP Sure Run Installed"
    (Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name like '%HP Sure Run%'").uninstall()
}else {
    write-host "HP Sure Run Not Installed"
}
# HP Sure Recover
if ((Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name like '%HP Sure Recover%'")) {
    write-host "HP Sure Recover Installed"
    (Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name like '%HP Sure Recover%'").uninstall()
}else {
    write-host "HP Sure Recover Not Installed"
}
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
# HP Wolf Security
if ((Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name like '%HP Wolf Security%'")) {
    write-host "HP Wolf Security Installed"
    (Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name like '%HP Wolf Security%'").uninstall()
}else {
    write-host "HP Wolf Security Not Installed"
}
# HP Security Update Service
if ((Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name like '%HP Security Update Service%'")) {
    write-host "HP Security Update Service Installed"
    (Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name like '%HP Security Update Service%'").uninstall()
}else {
    write-host "HP Security Update Service Not Installed"
}
exit 0