---
date:   2022-06-13 01:01:01 +1100
categories: 
---

# Call ps1 from ps1
Problem: 
- Got a Powershell script to call : TestMe.ps1
- Wanted to call that script multiple times

Action:
- Created a new Powershell script BulkTest.ps1 as below
```` Powershell
Write-Host "Hey you."
````


Solution:
Use one of the 2 syntax below
```` Powershell 
. .\TestMe.ps1
& $pwd\TestMe.ps1
````

Reference
- https://stackoverflow.com/questions/9394840/how-can-i-call-a-file-from-the-same-folder-that-i-am-in-in-script