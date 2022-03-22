$state = Get-WindowsCapability -Online | Where-Object Name -EQ "Language.Basic~~~ja-JP~0.0.1.0" | Select-Object state
if ($state -ccontains "NotPresent"){
    Write-Host "JPIME not installed"
    }
    else{
    write-host "JPIME Installed"
}