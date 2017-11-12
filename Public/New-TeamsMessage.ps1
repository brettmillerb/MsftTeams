function New-TeamsMessage {
    <#
    .SYNOPSIS
    Posts a new message to Teams as a connector card
    
    .DESCRIPTION
    Posts a new message to Teams as a connector card.
    Can accept a simple string message or a hashtable converted to string.
    
    .PARAMETER Message
    Simple String message consisting of alphanumeric characters
    
    .PARAMETER ConnectorTitle
    Main title of the connector card
    
    .PARAMETER ActivityTitle
    Activity to notify about

    .PARAMETER ActivitySubtitle
    Further information regarding the activity

    .PARAMETER information
    The body of information to be added to the connector card
    
    .PARAMETER proxy
    Proxy Switch if this is to be used when behind a proxy
    
    .EXAMPLE
    "This is a Teams message" | New-TeamsMessage
    Description
    -----------
    This command accepts pipeline input of string messages.

    .EXAMPLE
    New-TeamsMessage -Message 'This is a basic string Message'
    Description
    -----------
    This command allows string messages to be passed in as parameters

    .EXAMPLE
    $info = $hashtable | ConvertFrom-Hashtable
    New-TeamsMessage -ConnectorTitle 'Build for Customer ABC' -Information $Info
    Description
    -----------
    This command converts a hashtable to string input for more detailed output

    .EXAMPLE
    New-TeamsMessage -ConnectorTitle 'User Deletion Script' -Information $Info -Proxy
    Description
    -----------
    This command creates a connector card with only the Card Title and Information with the proxy switch 
    
    .NOTES
    Requires ActiveDirectory Module
    #>
    [CmdletBinding(DefaultParameterSetName = 'Simple')]
    Param (
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Simple',
                   ValueFromPipeline = $true,
                   ValueFromPipelineByPropertyName = $true)]
        [ValidatePattern('^[\w\d-: ]*$')]
        [string]$Message,
        
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Detailed')]
        [ValidatePattern('^[\w\d-: ]*$')]
        [string]$ConnectorTitle,

        [Parameter(Mandatory = $false,
                   ParameterSetName = 'Detailed')]
        [ValidatePattern('^[\w\d-: ]*$')]
        [string]$ActivityTitle,

        [Parameter(Mandatory = $false,
                   ParameterSetName = 'Detailed')]
        [ValidatePattern('^[\w\d-: ]*$')]
        [string]$ActivitySubtitle,
        
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Detailed')]
        [hashtable]$Information,

        [Parameter(Mandatory = $false,
                   ParameterSetName = 'Simple')]
        [Parameter(Mandatory = $false,
                   ParameterSetName = 'Detailed')]
        [string]$WebhookURI = "https://outlook.office.com/webhook/GUID",
        
        [string]$Proxy = $null
    )
    
    process {
        if ($message) {
            $body =  ConvertTo-Json @{
                text = $message
            }
        }
        else {
            if ($information) {
                $facts = $information | ConvertFrom-Hashtable
            }

            $body = ConvertTo-Json -Depth 4 @{
                Summary = 'Automation Alert Connector Card'
                title = $connectortitle
                sections = @(
                    @{
                        activityTitle = $activitytitle
                        activitySubtitle = $activitysubtitle
                    },
                    @{
                        title = 'Details:'
                        facts = $facts
                    }
                )
            }
        }

        $restparams = @{
            Uri = $WebhookURI
            Method = 'POST'
            Body = $body
            ContentType = 'application/JSON'
            Proxy = if ($Proxy) {$proxy}
        }

        Invoke-RestMethod @restparams | Out-Null
    }
}