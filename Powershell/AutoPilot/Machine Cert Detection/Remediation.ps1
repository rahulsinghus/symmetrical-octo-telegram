if (Get-ChildItem Cert:\LocalMachine\MY | Where-Object {$_.Subject -like "*$env:COMPUTERNAME*"})
{
    Write-Host "Present"
    exit 0
}Else
{
    Write-Host "Not Present"
    Get-ChildItem Cert:\LocalMachine\MY | Where-Object {($_.Issuer -like "CN=xxx, DC=xx, DC=xx, DC=LOCAL") -and ($_.EnhancedKeyUsageList -like "Client Authentication*") -and ($_.EnhancedKeyUsageList -like "Secure Email*")-and ($_.EnhancedKeyUsageList -like "Encrypting File System*")} | Remove-Item
    Write-Host "Machine Cert Deleted"
    Write-Host "Perform Machine Sync"
    Get-ScheduledTask | Where-Object {$_.TaskName -eq "PushLaunch"} | Start-ScheduledTask -ErrorAction SilentlyContinue
    exit 0
}