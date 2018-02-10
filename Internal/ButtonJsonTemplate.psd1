@{
    TextInput = @{
        "@type" = 'ActionCard'
        Name    = 'Comment'
        Inputs  = @(
            @{
                "@type"     = 'TextInput'
                id          = $null
                isMultiLine = $true
                title       = $null
            }
        )
        actions = @(
            @{
                "@type" = 'HttpPOST'
                Name    = $null
                target  = $null
            }
        )
    }
    DateInput = @{
        "@type" = 'ActionCard'
        Name    = 'Comment'
        Inputs  = @(
            @{
                "@type"     = 'DateInput'
                id          = $null
                isMultiLine = $true
                title       = $null
            }
        )
        actions = @(
            @{
                "@type" = 'HttpPOST'
                Name    = $null
                target  = $null
            }
        )
    }
    HttpPOST = @{
        'name'      = $null
        '@type'     = 'HttpPOST'
        'Target'    = $null 
    }
    OpenURI = @{
        'name'      = $null
        '@type'     = 'OpenURI'
        'Targets'   = @(
            @{
                'os'    = 'default'
                'uri'   = $null
            }
        )
    }
}