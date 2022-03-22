$GroupID = ""
$GroupMembers = Get-AzureADGroupMember -ObjectId $GroupID -All 1
foreach ($GroupMember in $GroupMembers) {
    $UserInfo = $GroupMember.Displayname+','+ $GroupMember.UserPrincipalName+','+ $GroupMember.Department+','+ $GroupMember.JobTitle+','+ $GroupMember.PhysicalDeliveryOfficeName
    $UserInfo | Out-File -FilePath C:\temp\GroupMembers.csv -Append
}


