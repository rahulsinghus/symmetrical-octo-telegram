Function Set-SecretKey
{
    Param
    (
        [Parameter(Mandatory=$true)]
        [String]$EncryptedPassword
    )
    $SecretKey = "pde68GSpel21#$%d^67Gfd"
    #Get key length.
    $Length = $SecretKey.Length;
    #Pad length.
    $Pad = 32-$Length;   
    #Create a new ASCII encoding object.
    $Encoding = New-Object System.Text.ASCIIEncoding;
    #Get byte array.
    $Bytes = $Encoding.GetBytes($SecretKey + "0" * $Pad);
    $Result =  ConvertTo-SecureString $EncryptedPassword -key $Bytes | ForEach-Object {[Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($_))};
    return $Result   
}
$EncryptedPassword = $args[0]
$result = Set-SecretKey($EncryptedPassword)
return $result