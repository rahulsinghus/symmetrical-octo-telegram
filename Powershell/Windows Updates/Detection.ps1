$WindowsTargetVersion = "20H2"

$BuildVersions = @(
[pscustomobject]@{BuildNumber ="18363"; ReleaseID = "1909"}
[pscustomobject]@{BuildNumber ="19041"; ReleaseID = "2004"}
[pscustomobject]@{BuildNumber ="19042"; ReleaseID = "20H2"}
)

$LogFile = "C:\Temp\PPD\WURemediation.log"
Function Write-Log
{
    [CmdletBinding()] 
    Param
    (
        [parameter(Mandatory=$true)][string]$File,
        [parameter(Mandatory=$true)][string]$Text,
        [parameter(Mandatory=$true)][string][ValidateSet("Information", "Error", "Warning")]$Status
    )    
    $Output = ("[Detection  ][" + (((Get-Date).ToShortDateString()) + "][" + (Get-Date).ToLongTimeString()) + "][" + $Status + "] " + $Text);
    $Output | Out-File -Encoding UTF8 -Force -FilePath $File -Append;
    Return Write-Output $Output;
} 

Write-Log -File $LogFile -Status Information -Text "CheckingWindowsUpdateStatus";
$BuildNumber = (Get-WMIObject win32_operatingsystem)
Write-Log -File $LogFile -Status Information -Text "Build Version is..."
Write-Log -File $LogFile -Status Information -Text $BuildNumber.Version
Write-Log -File $LogFile -Status Information -Text $BuildNumber.BuildNumber

$ReleaseID  = $BuildVersions | Where-Object BuildNumber -eq (Get-WMIObject win32_operatingsystem).BuildNumber

If($WindowsTargetVersion -eq ($ReleaseID).ReleaseID)
{
    Write-Log -File $LogFile -Status Information -Text  "Windows Version is...." 
    Write-Log -File $LogFile -Status Information -Text  $ReleaseID.ReleaseID
    Write-Log -File $LogFile -Status Information -Text  "Compliant"
    Exit 0
}
Else
{
    Try { 
        #Create Session COM object 
            Write-Log -File $LogFile -Status Information -Text  "Creating COM object for WSUS Session"
            $updatesession =  [activator]::CreateInstance([type]::GetTypeFromProgID("Microsoft.Update.Session",$c)) 
            } 
        Catch { 
            Write-Warning "$($Error[0])"
            Break
            } 
    #Configure Session COM Object 
    $Status_Update = 1
    Write-Log -File $LogFile -Status Information -Text  "Creating COM object for WSUS update Search"
    $updatesearcher = $updatesession.CreateUpdateSearcher() 
    $report1 = @()
    $report = Get-Date -Format "MM/dd/yyyy HH:mm:ss" |Out-String
    #Configure Searcher object to look for Updates awaiting installation 
    Write-Log -File $LogFile -Status Information -Text  "Searching for WSUS updates on client"
    $searchresult = $updatesearcher.Search("IsInstalled=0")  
    #Verify if Updates need installed 
    Write-Log -File $LogFile -Status Information -Text  "Verifing that updates are available to install"
    If ($searchresult.Updates.Count -gt 0) { 
        #Updates are waiting to be installed 
        Write-Log -File $LogFile -Status Information -Text  "Found $($searchresult.Updates.Count) update\s!"
        #Cache the count to make the For loop run faster 
        $count = $searchresult.Updates.Count 
      
        #Begin iterating through Updates available for installation 
        Write-Log -File $LogFile -Status Information -Text  "Iterating through list of updates"
        For ($i=0; $i -lt $Count; $i++) { 
            #Create object holding update 
            $update = $searchresult.Updates.Item($i) 
            #Write-Log -File $LogFile -Status Information -Text  $update

                #Verify that update has been downloaded 
            Write-Log -File $LogFile -Status Information -Text  "Checking to see that update has been downloaded"
            If ($update.IsDownLoaded -eq "True") {  
                Write-Log -File $LogFile -Status Information -Text  "Auditing updates"  
                $temp = "" | Select-Object KB,IsDownloaded,Title, Computer 
                $temp.Computer = $c 
                $temp.Title = ($update.Title -split('\('))[0] 
                $temp.KB = (($update.title -split('\('))[1] -split('\)'))[0] 
                $temp.IsDownloaded = "True" 
                $report1 += [pscustomobject]@{IsDownloaded = $temp.IsDownloaded ; Title = $temp.Title ; KB = $temp.KB}
#                $report += $temp |Out-String                
                $Status_Update = $Status_Update + 1001   
            } 
            Else { 
                Write-Log -File $LogFile -Status Information -Text  "Update has not been downloaded yet!" 
                $temp = "" | Select-Object KB,IsDownloaded, Title, Computer 
                $temp.Computer = $c 
                $temp.Title = ($update.Title -split('\('))[0] 
                $temp.KB = (($update.title -split('\('))[1] -split('\)'))[0] 
                $temp.IsDownloaded = "False" 
                $report1 += [pscustomobject]@{IsDownloaded = $temp.IsDownloaded ; Title = $temp.Title ; KB = $temp.KB}
#                $report += $temp |Out-String
                $Status_Update = $Status_Update + 1
                } 
            } 
    } 

Write-Log -File $LogFile -Status Information -Text  "Windows Updates Pending"

Foreach ($i in $report1)
{

   Write-Log -File $LogFile -Status Information -Text  $i
}
    Write-Log -File $LogFile -Status Information -Text  $Status_Update
    If($Status_Update -lt 1000)
    {Write-Log -File $LogFile -Status Information -Text  "No updates downloaded"
    #Exit 1
 }
    else
    {Write-Log -File $LogFile -Status Information -Text  "Updates downloaded"
    #Exit 0
    }
}