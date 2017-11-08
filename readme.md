# MSTeams Module

This module allows you to pass simple one-liner messages or hashtables to an Incoming Webhook configured in a channel within Microsoft Teams.

### You need to add your Webhook URL to the New-TeamsMessage.ps1 file to use this.
Replace the placeholder with your URL

*"https://outlook.office.com/webhook/GUID"*

### Known Quirks

* Passing Hashtables doesn't like values which are an array
   Think this is due to having to convert to string for the JSON conversion
## New-TeamsMessage
For posting messages to an Incoming Webhook within a Microsoft Teams channel.

### Simple Message Use
New-TeamsMessage -Message 'test message for teams'

### Detailed Message Use
New-TeamsMessage -ConnectorTitle 'This A Test Post To Teams' -ActivityTitle 'This works pretty well' -ActivitySubtitle 'Formatting is pretty good too' -Information $info

Passing Details information requires a hashtable of key / value pairs and can be created with the following

```$info = @{
    Enabled = $true
    givenname = 'Brett'
    emailaddress = 'brettm@opentext.com
    surname = 'Miller'
}```

```
New-TeamsMessage -ConnectorTitle 'Connector Title -ActivityTitle 'Activity Title' -ActivitySubtitle 'Activity Subtitle' -Information $info
```
