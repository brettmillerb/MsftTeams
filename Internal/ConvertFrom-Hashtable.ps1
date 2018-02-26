function ConvertFrom-Hashtable {
    <#
    .SYNOPSIS
    Converts a hashtable to a string format for JSON conversion
    
    .DESCRIPTION
    Converts a System.Collections.Specialized.OrderedDictionary to Selected.System.String
    This allows the information to be formatted correctly when converted to JSON
    
    .PARAMETER Hashtable
    Hashtable to convert
    
    .EXAMPLE
    $hashtable | ConvertFrom-Hashtable
    Description
    -----------
    This command passes a hashtable down the pipeline to convert to a string type.

    .EXAMPLE
    ConvertFrom-Hashtable -Hashtable $hashtable
    Description
    -----------
    This command passes the hashtable as a paramter to convert to a string type.
    
    .NOTES
    Converting a standard hashtable to JSON formatting does not create the array of key/values required.
    This was created as a quick way to convert a hashtable to string for JSON conversion.
    #>

    [CmdletBinding()]

    Param (
        [Parameter(Mandatory = $true,
                   Position = 0,
                   ValueFromPipeline = $true,
                   ValueFromPipelineByPropertyName = $true)]
        [hashtable]$Hashtable
    )

    Process {
            $Hashtable.keys | Select-Object @{name='Name';expression={$_}}, @{name='Value';expression={$hashtable[$_]}}
    }
}