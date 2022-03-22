#Uninstall Box 
if ((Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name like '%Box%'")) {
    write-host "Box Installed"
    (Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name like '%Box%'").uninstall()
    exit 0
}else {
    write-host "Box Not Installed"
    exit 0
}