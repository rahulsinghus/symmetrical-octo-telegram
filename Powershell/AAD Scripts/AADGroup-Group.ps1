
$group1 = ""
$group2 = ""

$AzureADGroup = Get-AzureADGroup -Filter "DisplayName eq '$Group1'" -All $true
$AzureADGroup | Get-AzureADGroupMember -All $true | Select-Object ObjectId | ForEach-Object{
    Add-AzureADGroupMember -ObjectId $group2 -RefObjectId $_.objectid 
}


