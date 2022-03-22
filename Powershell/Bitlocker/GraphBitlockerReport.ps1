$RussiaDevices = Get-Content C:\temp\russiadevices.txt
$counter = 0
$RussiaDevices | ForEach-Object{
    $counter++
    $session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
    $session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36 Edg/99.0.1150.39"
    $Dinfo = Invoke-RestMethod -UseBasicParsing -Uri "https://graph.microsoft.com/beta/deviceManagement/managedDevices?`$filter=(Notes%20eq%20%27bc3e5c73-e224-4e63-9b2b-0c36784b7e80%27)%20and%20(((deviceType%20eq%20%27desktop%27)%20or%20(deviceType%20eq%20%27windowsRT%27)%20or%20(deviceType%20eq%20%27winEmbedded%27)%20or%20(deviceType%20eq%20%27surfaceHub%27)%20or%20(deviceType%20eq%20%27desktop%27)%20or%20(deviceType%20eq%20%27windowsRT%27)%20or%20(deviceType%20eq%20%27winEmbedded%27)%20or%20(deviceType%20eq%20%27surfaceHub%27)%20or%20(deviceType%20eq%20%27windowsPhone%27)%20or%20(deviceType%20eq%20%27holoLens%27)))%20and%20(contains(activationlockbypasscode,%20%27$_%27))&`$top=25&`$skipToken=Skip=%270%27&`$select=deviceName,managementAgent,ownerType,complianceState,deviceType,userId,userPrincipalName,osVersion,lastSyncDateTime,isEncrypted,userPrincipalName,id,deviceRegistrationState,managementState,exchangeAccessState,exchangeAccessStateReason,deviceActionResults,deviceEnrollmentType" `
    -WebSession $session `
    -Headers @{
    "x-ms-client-session-id"="ac71ee68bfac41a8addb23d8e91949ca"
      "X-Content-Type-Options"="nosniff"
      "Accept-Language"="en"
      "Authorization"="Bearer $bearertoken"
      "x-ms-effective-locale"="en.en-us"
      "Accept"="*/*"
      "Referer"=""
      "x-ms-client-request-id"="5e433af1-4b75-4f00-b944-9578bd6adb3f"
      "client-request-id"="5e433af1-4b75-4f00-b944-9578bd6adb3f"
    }
    $outputinfo = $Dinfo.value | Select-Object deviceName,isEncrypted,lastSyncDateTime
    Write-Output $counter $outputinfo
    $Dinfo.value | Select-Object deviceName,isEncrypted,lastSyncDateTime | Export-Csv C:\temp\russiadevicesencryptedstatus.csv -Append
}


$IntuneObjNotFoundList = Get-Content C:\temp\IntuneObjNotFound.txt

$IntuneObjNotFoundList | ForEach-Object {
    $deviceinfor = Get-AzureADDevice -SearchString $_
    $deviceinfor | Select-Object DisplayName, ApproximateLastLogonTimeStamp | Export-Csv C:\temp\AAD_IntuneDeviceNotFound.csv -Append
}
