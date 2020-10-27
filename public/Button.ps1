function Button {
    <#
    .SYNOPSIS
    Creates a Button JSON object for use with MSTeams Module
    
    .DESCRIPTION
    Creates a Button Json object for use with MSTeams New-TeamsMessage function.
    This dynamically generates JSON for different button types based on the parameters passed
    
    .PARAMETER ButtonType
    The type of button to be used, there are four different types
    TextInput, DateInput, HttpPOST, OpenURI
    
    .PARAMETER ButtonName
    The text to appear on the button to be pressed
    
    .PARAMETER TargetURI
    The target URL that the button opens or attempts to POST a message.
    
    .EXAMPLE
    Button -ButtonType TextInput -ButtonName 'Leave a Comment' -TargetURI 'https://millerb.co.uk'

    .EXAMPLE
    Button -ButtonType DateInput -ButtonName 'Choose a Date' -TargetURI 'https://millerb.co.uk'

    .EXAMPLE
    Button -ButtonType HttpPost -ButtonName 'POST Stuff' -TargetURI 'https://millerb.co.uk'

    .EXAMPLE
    Button -ButtonType OpenURI -ButtonName 'Open Me :)' -TargetURI 'https://millerb.co.uk'
    
    .NOTES
    General Notes
    #>
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
        $scriptPath = split-path -parent $PSScriptRoot
        $buttonhash = Import-PowerShellDataFile $scriptPath\private\ButtonJsonTemplate.psd1
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
