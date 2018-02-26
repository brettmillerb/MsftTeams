@{
    TextInput = @{
        '@type'     = 'ActionCard'
        'Name'      = $null
        'Inputs'    = @(
            @{
                '@type'         = 'TextInput'
                'id'            = 'Comment'
                'isMultiLine'   = $true
                'title'         = 'Enter Your Text Input Here'
            }
        )
        actions = @(
            @{
                '@type'     = 'HttpPOST'
                'Name'      = 'OK'
                'target'    = $null
            }
        )
    }
    DateInput = @{
        '@type'     = 'ActionCard'
        'Name'      = $null
        'Inputs'    = @(
            @{
                '@type' = 'DateInput'
                'id'    = 'dueDate'
            }
        )
        actions = @(
            @{
                '@type'     = 'HttpPOST'
                'Name'      = 'OK'
                'target'    = $null
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