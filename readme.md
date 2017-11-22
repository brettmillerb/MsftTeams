# MSTeams Module

This module allows you to pass simple one-liner messages or hashtables of information to an Incoming Webhook configured in a channel within Microsoft Teams.

### Known Quirks

* Passing Hashtables doesn't like values which are an array
   Think this is due to having to convert to string for the JSON conversion

## New-TeamsMessage
For posting messages to an Incoming Webhook within a Microsoft Teams channel.

### Simple Message Use
`New-TeamsMessage -Message 'test message for teams' -Color Red`

### Detailed Message Use

Passing Details information requires a hashtable of key / value pairs and can be created with the following

```
$info = @{
    Enabled = $true
    givenname = 'Brett'
    emailaddress = 'brettm@millerb.co.uk
    surname = 'Miller'
}
```

`New-TeamsMessage -Title 'This A Test Post To Teams' -Text 'This is the Text on the card' -ActivityTitle 'This works pretty well' -ActivitySubtitle 'Formatting is pretty good too' -Information $info -Color Green`


### Splatting Parameters

```
$params = @{
    Title = 'Title of the Connector Card'
    Text = 'Text of the Connector Card'
    ActivityTitle = 'Activity title of the card'
    ActivitySubtitle = 'Activity Subtitle of the card'
    Facts = $info
    color = 'green'
    webhookuri = $uri
}
```

`New-TeamsMessage @params`