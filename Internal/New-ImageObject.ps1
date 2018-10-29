function New-ImageObject {
    param (
        [Parameter(Mandatory = $true,
            Position = 0)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string[]]$TargetURI,

        [Parameter(Mandatory = $false,
            Position = 1)]
        [string]$Title
    )

    foreach ($image in $TargetURI) {
        $ImageHash = Import-PowerShellDataFile -Path $PSScriptRoot\ImageJsonTemplate.psd1
        $ImageHash.image = $image
        $ImageHash
    }
}