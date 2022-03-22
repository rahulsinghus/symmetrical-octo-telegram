import-module Active Directory
#Get the content of the file and store it in a variable called $List
$List=Get-Content c:\inputFile.txt
#Foreach element in the $list, execute the code To add computers into the group
$groupname = "groupname"
$List | ForEach-Object {
    Add-ADGroupMember -id $groupname -MEMBERS (Get-ADComputer $_)
 }