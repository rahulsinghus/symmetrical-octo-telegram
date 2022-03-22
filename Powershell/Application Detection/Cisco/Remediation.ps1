if ((Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name like 'Cisco AnyConnect Secure Mobility Client'")) {
    write-host "Cisco AnyConnect Secure Mobility Client Installed - Will initiate uninstall"
    (Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name like 'Cisco AnyConnect Secure Mobility Client'").uninstall()
    exit 0
    }else {
    write-host "Cisco AnyConnect Secure Mobility Client Uninstalled"
    exit 0
    }