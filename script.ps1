Add-Type -TypeDefinition @"
using System;
using System.Diagnostics;
using System.Text;
using System.Runtime.InteropServices;
using System.ComponentModel;
using System.Security.Cryptography;
 
public static class Test
{
    public static byte [] Unprotect( byte [] data )
    {
        try
        {
            //Decrypt the data using DataProtectionScope.CurrentUser.
            return System.Security.Cryptography.ProtectedData.Unprotect( data, null, DataProtectionScope.CurrentUser );
        }
        catch (CryptographicException e)
        {
            Console.WriteLine("Data was not decrypted. An error occurred.");
            Console.WriteLine(e.ToString());
            return null;
        }
    }
}
"@ -ReferencedAssemblies "System.Security.dll"

[System.Text.Encoding]::ASCII.GetString([Test]::Unprotect([System.IO.File]::ReadAllBytes('C:\Users\Sarthak\AppData\Roaming\MySQL\Workbench\workbench_user_data.dat')))
