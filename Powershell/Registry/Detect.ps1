if (Test-Path  ("HKCU:\SOFTWARE\DontTouchMe")) 
{return $true}
Else
{return $false}