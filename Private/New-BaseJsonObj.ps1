function New-BaseJsonObj {
    $BaseJsonObj = Import-LocalizedData -BaseDirectory $PSScriptRoot -FileName 'BaseJsonTemplate.psd1'
    $BaseJsonObj.BaseJson | ConvertFrom-Json 
}