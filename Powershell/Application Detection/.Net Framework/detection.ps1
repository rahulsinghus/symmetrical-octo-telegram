$versions = Get-ChildItem $Env:windir\Microsoft.NET\Framework | Select-Object name

if (($versions.name -match "v2.0")-and($versions.name -match "v3.0")) {
    Write-Host "Compliant"
    exit 0
}else {
    Write-Host "Non-Compliant"
    exit 1
}