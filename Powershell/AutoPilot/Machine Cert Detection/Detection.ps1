if (Get-ChildItem Cert:\LocalMachine\MY | Where-Object {$_.Subject -like "*$env:COMPUTERNAME*"})
{
    Write-Host "Present"
    exit 0
}Else
{
    Write-Host "Not Present"
    exit 1
}