$safesenders = @"
@microsoft.com
@yammer.com
@mail.fidelity.com
"@
New-Item -Path C:\ProgramData -Name xxx -ItemType Directory -Force

$safesenders | out-file -FilePath C:\ProgramData\xxx\safesenders.txt
exit 0