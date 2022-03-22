Get-Content "\Machines.txt" | foreach { Get-CMCollectionMember -CollectionId "" -ResourceID (Get-CMDevice -Name $_).ResourceID }

$input = $psscriptroot + "\Machines.txt"
$outfile = $psscriptroot + "\Output.txt"

$computers = Get-Content $input

foreach ($computer in $computers )
{
    if (Test-Connection -IPAddress $computer -Count 1 -Quiet)
    {
        Write-Host "$computer is Online"
        #"$computer is Online" | Out-File -Append -FilePath $Outfile -Force;
    }
    Else
        {
        Write-Host "$computer is Offline"
        #"$computer is Offline" | Out-File -Append -FilePath $Outfile -Force;
        }
}