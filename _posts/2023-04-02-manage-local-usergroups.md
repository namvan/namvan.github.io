---
layout: post
title: Manage Local User Groups
date: 2023-04-02 23:15:01 +1100
categories: 
---

Local User Groups can be managed using Powershell, more details here https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.localaccounts/add-localgroupmember?view=powershell-5.1

```powershell
Add-LocalGroupMember -Group "Administrators" -Member "ORG\Application Support - Dreamers"
Remove-LocalGroupMember -Group "Administrators" -Member "ORG\Application Support - Dreamers"
```


