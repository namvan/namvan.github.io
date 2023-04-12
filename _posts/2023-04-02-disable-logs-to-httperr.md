---
layout: post
title: Turn off httperr (Http error) log files
date: 2023-04-02 22:55:01 +1100
categories: 
---

After setting up reverse proxy from Apache httpd to the services in SF nodes, a huge number of log files are out to C:\Windows\System32\LogFiles\HTTPERR\

To turn off this behaviour, a key must be added to Windows Registry. Read more from here
1. https://www.xglobe.com/knowledgebase/windows/logs/how-to-turn-off-httperr-(http-error)-log-files/
2. https://learn.microsoft.com/en-us/windows/win32/http/configuring-http-server-api-error-logging

Registry can be modified using Powershell as below

```powershell
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\HTTP\Parameters" -Name "EnableErrorLogging" -Value 0 -PropertyType DWORD -Force 
```

From the doco, Configuration information in the registry values is read when the HTTP Server API driver is started. As a result, if the settings are changed the driver must be stopped and restarted to read the new values. This can be accomplished by using the following console commands:

```cmd
net stop http
net start http
```

Quick reaction is to delete all current files from the folder to recover space

```powershell
Remove-Item C:\Windows\System32\LogFiles\HTTPERR\*.*
```

