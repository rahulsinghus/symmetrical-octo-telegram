$AzureADGroups = @("",
"",
"",
"",
"",
"")
foreach ($AADGroup in $AzureADGroups) {
    $AzureADGroup = Get-AzureADGroup -Filter "DisplayName eq '$AADGroup'" -All $true
    $AzureADUsers = $AzureADGroup | Get-AzureADGroupMember -All $true
    $AADGroupCount = $AzureADUsers | Measure-Object
    Write-Host $AADGroup ": " $AADGroupCount.Count    
}