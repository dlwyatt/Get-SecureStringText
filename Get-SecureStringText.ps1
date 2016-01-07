function Get-SecureStringText
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,
                   Position=0,
                   ValueFromPipeline=$true)]
        [System.Security.SecureString[]]
        $SecureString
    )

    process
    {
        foreach ($ss in $SecureString)
        {
            $ptr = $null
            try
            {
                $ptr = [System.Runtime.InteropServices.Marshal]::SecureStringToGlobalAllocUnicode($ss)
                [System.Runtime.InteropServices.Marshal]::PtrToStringUni($ptr)
            }
            catch
            {
                Write-Error -ErrorRecord $_
            }
            finally
            {
                if ($ptr)
                {
                    [System.Runtime.InteropServices.Marshal]::ZeroFreeGlobalAllocUnicode($ptr)
                }
            }
        }
    }
}
