# Cisco AnyConnect Secure Mobility Client
if ((Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name like 'Cisco AnyConnect Secure Mobility Client'")) {
    write-host "Cisco AnyConnect Secure Mobility Client Installed"
    exit 1
    }else {
    write-host "Cisco AnyConnect Secure Mobility Client Uninstalled"
    exit 0
    }