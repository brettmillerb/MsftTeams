function Button {
    Param (
        [Parameter(Mandatory = $true,
            Position = 0)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('TextInput','DateInput','HttpPost','OpenURI')]
        [string]$ButtonType,

        [Parameter(Mandatory = $true,
            Position = 1)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$ButtonName,

        [Parameter(Mandatory = $true,
            Position = 2)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$TargetURI
    )

    begin {
        $buttonhash = Import-PowerShellDataFile $PSScriptRoot\internal\ButtonJsonTemplate.psd1
        $typehash = $buttonhash[$PSBoundParameters.ButtonType]
    }
    process {
        if ($PSBoundParameters.ContainsKey('ButtonName')) {
            $typehash.Name = $ButtonName
        }
        if ($PSBoundParameters.ContainsKey('TargetURI') -and $ButtonType -eq 'OpenURI') {
            $typehash.targets[0].uri = $TargetURI
        }
        elseif ($PSBoundParameters.ContainsKey('TargetURI') -and $ButtonType -eq 'HttpPOST') {
            $typehash.target = $TargetURI
        }
        else {
            $typehash.actions[0].target = $TargetURI
        }

        $typehash
    }
}