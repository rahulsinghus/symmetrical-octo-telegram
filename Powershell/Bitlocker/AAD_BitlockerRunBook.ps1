#Client and user data
$AccountName = "username@onmicrosoft.com"
$AccountPassword = 'XXXXXXXXXXXXX'
$ClientId = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXX"
$ClientSecret = 'XXXXXXXXXXXXXXXXXXXXXX'
$TenantID = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXX"
$GraphUri = 'https://graph.microsoft.com'
$GraphVersion = 'beta'

# Authentication url
$AzureResourceURI = "https://login.microsoftonline.com/$TenantID/oauth2/v2.0/token"

# Construct the Body for the POST
$Body = "grant_type=password"`
 + "&username=" + $Accountname `
 + "&client_id=" + $ClientId `
 + "&client_secret=" + $ClientSecret`
 + "&password=" + $AccountPassword `
 + "&scope=https://graph.microsoft.com/.default"

# The result should contain a token for use with Graph
$Response = Invoke-WebRequest -Uri $AzureResourceURI -Method POST -Body $Body -UseBasicParsing
$ResponseJSON = $Response | ConvertFrom-Json

# Add the token to headers for the Graph request
$Headers = @{
Authorization = "Bearer " + $ResponseJSON.access_token
}

#Run API call
$Deviceuri = "$GraphUri/$GraphVersion/devices'
$AllDevices = Invoke-RestMethod -Uri $Deviceuri -Headers $Headers -Method Get