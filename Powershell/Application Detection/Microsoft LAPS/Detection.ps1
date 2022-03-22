# Local Administrator Password Solution 
if ((Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name like 'Local Administrator Password Solution'")) {
    write-host "Local Administrator Password Solution Installed"
    exit 1
}else {
    write-host "Local Administrator Password Solution Uninstalled"
    exit 0
}