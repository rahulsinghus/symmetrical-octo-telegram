# Make sure you are authenticated with 
# Connect-AzAccount


[string]$WorkspaceID = ''

$Query = @'

AppInventory_CL
| where TimeGenerated > ago(1d)
| where AppName_s contains "Microsoft 365 Apps for enterprise - en-us" and AppModifyPath_s contains "platform=x64"
| where AzureADDeviceID_g != ""
| summarize arg_max (TimeGenerated, *) by ComputerName_s
| project AzureADDeviceID_g

'@

$Results = Invoke-AzOperationalInsightsQuery -WorkspaceId $WorkspaceID -Query $Query

$Results.Results |  ForEach-Object {
    write-host $_
}
