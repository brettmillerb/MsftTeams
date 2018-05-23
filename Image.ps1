function Image {
    param (
        [Parameter(Mandatory = $true,
            Position = 0)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$TargetURI,

        [Parameter(Mandatory = $false,
            Position = 1)]
        [string]$Title
    )
    
    begin {
        $ImageHash = Import-PowerShellDataFile -Path C:\users\brettm\github\msteams\Internal\ImageJsonTemplate.psd1
    }
    
    process {
        if ($PSBoundParameters.ContainsKey('TargetURI')) {
            $ImageHash.image = $TargetURI
        }

        $ImageHash
    }
    
}