$browser = (Get-ItemProperty HKCU:\Software\Microsoft\windows\Shell\Associations\UrlAssociations\http\UserChoice).Progid

if ($browser -eq "IE.HTTP") {
    Write-Host $browser ": Browser Internet Explorer"
    exit 1
}else {
    Write-Host $browser ": Browser Not IE"
    exit 0
}