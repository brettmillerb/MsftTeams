function New-TeamsMessage {
    [CmdletBinding(DefaultParameterSetName = 'Simple')]
    
    Param (
        [Parameter(Mandatory = $true,
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
    
    process {
        if ($CardText) {
                $JSONHash.text = $CardText
        }
        if ($CardTitle) {
            $JSONHash.title = $CardTitle
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