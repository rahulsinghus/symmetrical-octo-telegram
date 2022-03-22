#Connect-AzureAD

$List=Get-Content ""
$GroupID = ""
$List | ForEach-Object {
    $DeviceID = Get-AzureADDevice -SearchString $_
    Write-Host $DeviceID.objectid
    foreach ($item in $DeviceID) {
        Add-AzureADGroupMember -ObjectId $GroupID -RefObjectId $item.objectid
    }
    Write-Host $DeviceID.DisplayName
}