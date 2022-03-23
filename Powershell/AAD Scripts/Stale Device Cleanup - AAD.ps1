$tenantid = ""
$clientID = ""
$certificateThumb = ""
Connect-MgGraph -TenantId $tenantid -ClientId $clientID -CertificateThumbprint $certificateThumb

$dt90 = [datetime]::Today.AddDays(-90).ToUniversalTime()
$dt180 = [datetime]::Today.AddDays(-180).ToUniversalTime()

$Devices = Get-MgDevice -All:$true | Where-Object {$_.ApproximateLastSignInDateTime -ge $dt90} | Select-Object -Property ApproximateLastSignInDateTime, DisplayName, AccountEnabled

foreach ($Device in $Devices) {
	$D = $Device.DisplayName
    If(($_.ApproximateLastSignInDateTime -le $dt180) -and ($_.AccountEnabled -eq $false)){
        Remove-MgDevice -ObjectId $Device.ObjectId -whatif
        write-output "$D is deleted."
    }
    ElseIf($_.ApproximateLastSignInDateTime -le $dt90) {
        Update-MgDevice -ObjectId $Device.ObjectId -AccountEnabled $false -whatif
        write-output "$D is disabled."
    }
}