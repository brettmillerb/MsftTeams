@{
    BaseJson = @{
        '@type'     =  'MessageCard'
        '@Context'  =  'http://schema.org/extensions'
        'Summary'     = $null
        'themeColor'  = $null
        'title'       = $null
        'text'        = $null
        'sections'    = @(
            @{
                'activitytitle'         = $null
                'activitysubtitle'      = $null
                'images'                = @()
            }
            @{
                'facts'             = $null
                'potentialAction'   = @(
                    @{
                        'name'      = $null
                        '@type'     = 'OpenUri'
                        'targets'   = @(
                            @{
                                'os'  = 'default'
                                'uri' = $null
                            }
                        )
                    }
                )
            }
        )
    }
}