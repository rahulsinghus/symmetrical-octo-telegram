$User = ""
$GroupID = ""
$userID = get-azureaduser -Filter "userPrincipalName eq '$User'"
Add-AzureADGroupMember -ObjectId $GroupID -RefObjectId $userID.ObjectId