#my script
$status = Get-BitLockerVolume -MountPoint "c:" | Select-Object -Property "VolumeStatus"
if ($status -match "FullyEncrypted"){
    Write-Host "Compliant"
    exit 1
}
else{
    Write-Host "Non-Compliant"
    exit 0
}

#Anthony's Script
$BitLockerOSVolume = Get-BitLockerVolume -MountPoint $env:SystemRoot 
  if (($BitLockerOSVolume.VolumeStatus -like "FullyEncrypted") -and ($BitLockerOSVolume.KeyProtector.Count -eq 2)) 
  { 
    return "compliant" 
    exit 1
 
}elseif (($BitLockerOSVolume.VolumeStatus -like "FullyDecrypted") -and ($BitLockerOSVolume.KeyProtector.Count -eq 0)){ 
    return "non-compliant"
    exit 0 
}