function Button {
    Param (
        [string]$name,
        [string]$url
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