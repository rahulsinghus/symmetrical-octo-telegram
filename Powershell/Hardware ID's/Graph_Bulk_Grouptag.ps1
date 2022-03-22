#####MS-Graph & MGGraph Authentication
$tenant = #"Tenantid"
$authority = "https://login.windows.net/$tenant"
$clientId = #"Client ID"
$clientSecret = #"Client Secret"
Update-MSGraphEnvironment -AppId $clientId -Quiet
Update-MSGraphEnvironment -AuthUrl $authority -Quiet
Connect-MSGraph -ClientSecret $ClientSecret -Quiet
Connect-MgGraph -TenantId $tenant -ClientId $clientid -CertificateThumbprint $certificatethumbprint

# Get all autopilot devices (even if more than 1000)
$autopilotDevices = Invoke-MSGraphRequest -HttpMethod GET -Url "deviceManagement/windowsAutopilotDeviceIdentities" | Get-MSGraphAllPages

# Display gridview to show devices
$selectedAutopilotDevices =  $autopilotDevices | Out-GridView -OutputMode Multiple -Title "Select Windows Autopilot entities to update"

$selectedAutopilotDevices | ForEach-Object {

    $autopilotDevice = $PSItem

    # Change names according to your environment
    $autopilotDevice.groupTag = "Group_Tag"

    $requestBody=
@"
    {
        groupTag: `"$($autopilotDevice.groupTag)`",
    }
"@
    Write-Output "Updating entity: $($autopilotDevice.id) | groupTag: $($autopilotDevice.groupTag) | orderIdentifier: $($autopilotDevice.orderIdentifier)"
    Invoke-MSGraphRequest -HttpMethod POST -Content $requestBody -Url "deviceManagement/windowsAutopilotDeviceIdentities/$($autopilotDevice.id)/UpdateDeviceProperties" 
}

# Invoke an autopilot service sync
#Invoke-MSGraphRequest -HttpMethod POST -Url "deviceManagement/windowsAutopilotSettings/sync" 
#Invoke-MSGraphRequest -HttpMethod GET -Url "deviceManagement/windowsAutopilotDeviceIdentities/4b199661-5fb2-4166-9074-848c90d1ecca"
