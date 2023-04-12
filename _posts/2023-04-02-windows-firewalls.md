---
layout: post
title: Turn off Windows Firewall remotely
date: 2023-04-02 22:45:01 +1100
categories: 
---

Windows Firewall can be turned off remotely. More info can be read here https://learn.microsoft.com/en-us/powershell/module/netsecurity/set-netfirewallprofile?view=windowsserver2022-ps

```powershell
Invoke-Command -ComputerName RemotePcName -ScriptBlock {Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False}
```

```cmd
netsh -r RemotePcName -u uid -p passcode -c advfirewall set allprofiles state off
```

