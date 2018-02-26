function New-BaseJsonObj {
    $BaseJsonObj = Import-PowerShellDataFile -Path $PSScriptRoot\BaseJsonTemplate.psd1
    $BaseJsonObj.BaseJson
}