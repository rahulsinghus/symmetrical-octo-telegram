if ((Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name like '%Microsoft Monitoring Agent%'")) {
    write-host "Microsoft Monitoring Agent Installed"
    (Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name like '%Microsoft Monitoring Agent%'").uninstall()
}else {
    write-host "Microsoft Monitoring Agent Not Installed"
}