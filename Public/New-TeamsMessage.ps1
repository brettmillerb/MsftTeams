function New-TeamsMessage {
    <#
    .SYNOPSIS
    Posts a new message to Incoming Webhook in MSTeams as a connector card
    
    .DESCRIPTION
    Enables construction of Connector Cards to be passed to the Incoming Webhook of a MS Teams Channel
    This can accept hashtables as part of the Connector Card
    
    .PARAMETER Text
    A simple message to post to a Connector Card - Supports Markdown
    
    .PARAMETER Title
    Title of the Connector Card - Appears at the top of the card in large text formatting
    
    .PARAMETER ActivityTitle
    Heading for the Activity Title within a section on the Connector Card
    
    .PARAMETER ActivitySubtitle
    Further information regarding the passed information
    
    .PARAMETER Facts
    Hashtable or Ordered Dictionary to display on the Connector Card
    
    .PARAMETER Color
    Colour Highlighting of the Connector Card
    
    .PARAMETER WebhookURI
    The URL from the Incoming Webhook which is to display the information
    
    .PARAMETER Proxy
    Proxy Switch so you can define a proxy to Invoke-RestMethod
    
    .EXAMPLE
    New-TeamsMessage -Text 'This is a simple Message'

    .EXAMPLE
    New-TeamsMessage -Title 'This is the card title' -Text 'This is the card Text' -Color Red
    
    .NOTES
    General notes
    #>
    [CmdletBinding(DefaultParameterSetName = 'Simple')]
    
    Param (
        [Parameter(Mandatory = $true,
                   Position = 0,
                   ParameterSetName = 'Simple',
                   ValueFromPipeline = $true,
                   ValueFromPipelineByPropertyName = $true)]
        [Parameter(Mandatory = $false,
                   ParameterSetName = 'Detailed')]
        [ValidatePattern('^[\w\d-:*_ ]*$')]
        [string]$Text,
        
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Detailed')]
        [ValidatePattern('^[\w\d-:*_ ]*$')]
        [string]$Title,
        
        [Parameter(Mandatory = $false,
                   ParameterSetName = 'Detailed')]
        [ValidatePattern('^[\w\d-:*_ ]*$')]
        [string]$ActivityTitle,

        [Parameter(Mandatory = $false,
                   ParameterSetName = 'Detailed')]
        [ValidatePattern('^[\w\d-:*_ ]*$')]
        [string]$ActivitySubtitle,
        
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Detailed')]
        [hashtable]$Facts,

        [Alias('Colour')]
        [string]$Color,

        [string]$WebhookURI = "https://outlook.office.com/webhook/GUID",
        
        [string]$Proxy = $null
    )

    begin {
        $JSONHash = New-BaseJsonObj
    }
    
    process {
        if ($Text) {
            $JSONHash.text = $Text
        }
        if ($Title) {
            $JSONHash.title = $Title
        }
        if ($ActivityTitle) {
            $JSONHash.sections.activitytitle = $ActivityTitle
        }
        if ($ActivitySubtitle) {
            $JSONHash.sections.activitysubtitle = $ActivitySubtitle
        }
        if ($Facts) {
            $JSONHash.sections[1].facts = $Facts | ConvertFrom-Hashtable
        }
        if ($Color) {
            $JSONHash.themeColor = $ColorMap[$Color]
        }

        $body = $JSONHash | ConvertTo-Json -Depth 10

        $restparams = @{
            Uri = $WebhookURI
            Method = 'POST'
            Body = $body
            ContentType = 'application/JSON'
            Proxy = if ($Proxy) {$proxy}
        }

        $null = Invoke-RestMethod @restparams
    }
}