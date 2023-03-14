---
layout: post
date:   2022-06-13 01:01:01 +1100
categories: 
---

# Powershell stuff

\- Print text in colours?
``` Powershell
Write-Host "This text should be in red" -foreground "Red"
```

\- Add members (users) to the (local) Administrators group?  
This command adds several members to the local Administrators group. The new members include a local user account, a Microsoft account, an Azure Active Directory account, and a domain group. This example uses a placeholder value for the user name of an account at Outlook.com.
``` Powershell
Add-LocalGroupMember -Group "Administrators" -Member "Admin02", "MicrosoftAccount\username@Outlook.com", "AzureAD\Dando@contoso.com", "CONTOSO\Domain Admins"
```

\- Prettify json?   
\- see here https://stackoverflow.com/questions/24789365/prettify-json-in-powershell-3
```powershell
$jsonString = '{ "baz": "quuz", "cow": [ "moo", "cud" ], "foo": "bar" }'
$jsonString | ConvertFrom-Json | ConvertTo-Json 
```

\- How to find Account ID from Atlassian?
\- See here https://community.atlassian.com/t5/Jira-questions/how-to-find-accountid/qaq-p/1111436