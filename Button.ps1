function Button {
    Param (
        [string]$Name,
        [string]$Url
    )
    process {
        @(    
            @{
                'name'      = $name
                '@type'     = 'OpenURI'
                'Targets'   = @(
                    @{
                        'os'    = 'default'
                        'uri'   = $url
                    }
                )
            }
        )
    }
}