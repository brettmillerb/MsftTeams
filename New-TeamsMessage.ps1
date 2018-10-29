function New-TeamsMessage {
    <#
    .SYNOPSIS
    Posts a new message to Incoming Webhook in MSTeams as a connector card
    
    .DESCRIPTION
    Enables construction of Connector Cards to be passed to the Incoming Webhook of a MS Teams Channel
    This can accept hashtables as part of the Connector Card
    
    .PARAMETER Message
    A simple message to post to a Connector Card - Supports Markdown

    .PARAMETER Title
    Title of the Connector Card - Appears at the top of the card in large text formatting
    
    .PARAMETER Text
    A simple message to post to a Connector Card - Supports Markdown
    
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
    [CmdletBinding(DefaultParameterSetName = 'Simple',
        SupportsShouldProcess = $true)]
    
    Param (
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Simple',
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [string]$message,

        [Parameter(Mandatory = $false,
            ParameterSetName = 'Detailed')]
        [string]$Title,
        
        [Parameter(Mandatory = $false,
            ParameterSetName = 'Detailed')]
        [string]$Text,
        
        [Parameter(Mandatory = $false,
            ParameterSetName = 'Detailed')]
        [string]$ActivityTitle,

        [Parameter(Mandatory = $false,
            ParameterSetName = 'Detailed')]
        [string]$ActivitySubtitle,
        
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Detailed')]
        [hashtable]$Facts,

        [Parameter(Mandatory = $false,
            ParameterSetName = 'Detailed')]
        [scriptblock]$Button,

        [Parameter(Mandatory = $false,
            ParameterSetName = 'Detailed')]
        [string[]]$Image,

        [Alias('Colour')]
        [string]$Color,

        [string]$WebhookURI = "https://outlook.office.com/webhook/GUID",
        
        [string]$Proxy = $null
    )

    begin {
        $JSONHash = New-BaseJsonObj
    }
    
    process {
        if ($PSBoundParameters.ContainsKey('Text')) {
            $JSONHash.text = $Text
        }
        if ($PSBoundParameters.ContainsKey('Message')) {
            $JSONHash.text = $message
        }
        if ($PSBoundParameters.ContainsKey('Title')) {
            $JSONHash.title = $Title
        }
        if ($PSBoundParameters.ContainsKey('ActivityTitle')) {
            $JSONHash.sections[0].activitytitle = $ActivityTitle
        }
        if ($PSBoundParameters.ContainsKey('ActivitySubtitle')) {
            $JSONHash.sections[0].activitysubtitle = $ActivitySubtitle
        }
        if ($PSBoundParameters.ContainsKey('Facts')) {
            $JSONHash.sections[1].facts = $Facts | ConvertFrom-Hashtable
        }
        if ($PSBoundParameters.ContainsKey('Color')) {
            $JSONHash.themeColor = $ColorMap[$Color]
        }
        if ($PSBoundParameters.ContainsKey('Button')) {
            $JSONHash.sections[1].potentialAction = @(& $Button)
        }
        if ($PSBoundParameters.ContainsKey('Image')) {
            $JSONHash.sections[0].images = @(New-ImageObject -TargetURI $Image)
        }

        $body = $JSONHash | ConvertTo-Json -Depth 10

        Write-Verbose $body

        $restparams = @{
            Uri = $WebhookURI
            Method = 'POST'
            Body = $body
            ContentType = 'application/JSON'
            Proxy = if ($Proxy) {$proxy}
        }
        
        try {
            if ($pscmdlet.ShouldProcess("MSTeams Channel", "Sending Message $($JSONHash.text)")) {
                $null = Invoke-RestMethod @restparams -ErrorAction Stop
            }
        }
        catch {
            $_.exception.message
        }
    }
}