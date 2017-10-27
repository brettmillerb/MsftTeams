# MSTeams Module

This module allows you to pass simple one-liner messages or hashtables to an Incoming Webhook configured in a channel within Microsoft Teams.

### You need to add your Webhook URL to the New-TeamsMessage.ps1 file to use this.
Replace the placeholder with your URL

*"https://outlook.office.com/webhook/GUID"*

### Known Quirks

* Passing Hashtables doesn't like values which are an array
   Think this is due to having to convert to string for the JSON conversion
