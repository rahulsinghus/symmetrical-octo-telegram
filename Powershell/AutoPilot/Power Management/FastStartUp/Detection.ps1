$regkey = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power"
$ValueName = "HiberbootEnabled"

if ((Get-ItemProperty $regkey).PSObject.Properties.Name -contains $ValueName) {
    $val = Get-ItemProperty -Path $regkey -Name $ValueName
    if ($val.HiberbootEnabled -eq 1) {
        Write-Host "Key Value 1 - Remediation Required"
        exit 1
    }else {
        Write-Host "No Remediation Required"
        exit 0
    }
}else {
    Write-Host "Key Absent - Remediation Required"
    exit 1    
}