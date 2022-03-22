#delete old LGPO_Registry.txt file
$path = "c:\windows\Logs\GPOCorruption\LGPO_registry.txt"
remove-item -path $path
#Run the LGPO.exe and regenerate results
c:\Windows\LGPO.exe /parse /m c:\windows\system32\grouppolicy\machine\registry.pol > C:\Windows\Logs\GPOCorruption\LGPO_registry.txt 2>&1

#Read the LGPO_Registry.txt file
if(test-path $path)
{
    if((select-string -path $path -pattern 'PARSING COMPLETED')-ne $null)
    {
        write-host "GPO Not Corrupt"
        exit 0
    }else{
        write-host "GPO Corrupt"
        exit 1
    }
}
write-host "File Not Found"
exit 0
