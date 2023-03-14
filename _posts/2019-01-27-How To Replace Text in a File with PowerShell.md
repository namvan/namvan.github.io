https://webcache.googleusercontent.com/search?q=cache:KjytUieK9H0J:https://mcpmag.com/articles/2018/08/08/replace-text-with-powershell.aspx+&cd=1&hl=en&ct=clnk&gl=au

How To Replace Text in a File with PowerShell
By Adam Bertram
08/08/2018

Using built-in cmdlets that come with PowerShell, we can easily read and replace any kind of content inside of a text file. Whether the string to find inside of the text file is just a single word or a complicated pattern, PowerShell has the ability to find and replace just about anything.

To demonstrate this ability, let's start out with a simple example. Perhaps we've got a text file with a single sentence in it: "The quick brown fox jumped over the lazy dog." In this text file, I'd like to replace the word "brown" with "white." To do that, I'll first need to read the text file using the Get-Content cmdlet.

PS C:> Get-Content -path C:ReplaceDemo.txt
The quick brown fox jumped over the lazy dog
You can see that Get-Content read the file and returned the contents to the console, but it did this by returning an array. In this case, this was an array of 1. To perform a find/replace in a text file, it's much easier to return the contents via single string. We'll add the Raw parameter to do that.

PS C:> Get-Content -path C:ReplaceDemo.txt -Raw
The quick brown fox jumped over the lazy dog
Next, we'll have to figure out a way to find and replace the string "brown" in memory. We're not actually changing the file yet. To make that happen, we'll use PowerShell's replace operator. The replace operator takes as arguments the string to find and the string to replace it with. This operator can be used against any string.

Below you can see how it's being used in-line against the output of Get-Content. The replace operator returns the new string. Notice that the Get-Content command execution is in parentheses. This is required to ensure Get-Content is complete before attempting any replace operation on its output.

PS> (Get-Content -path C:ReplaceDemo.txt -Raw) -replace 'brown','white'
The quick white fox jumped over the lazy dog
Now that we have the code to find and replace the string we're after, it's now time to modify the file itself. We can do that by using Set-Content. Unlike Add-Content, Set-Content overwrites a file. In this instance, we're overwriting the entire file with the string output that the replace operator returned.

Below, I've wrapped the whole previous operation in parentheses to ensure PowerShell doesn't try to pass any output prematurely to Set-Content. After Get-Content reads the file and passes the string to the replace operator, PowerShell then hands off that new string to Set-Content, which takes that string as pipeline input and overwrites the existing file. Voila!

PS C:> ((Get-Content -path C:ReplaceDemo.txt -Raw) -replace 'brown','white') | Set-Content -Path C:ReplaceDemo.txt
PS C:> Get-Content -path C:ReplaceDemo.txt
The quick white fox jumped over the lazy dog
There are countless other ways to replace strings in a text file with PowerShell. It's possible to use regular expressions with the replace operator to find complex strings, use regular expression groups and a whole lot more. The world is your oyster now, my friend!

About the Author


Adam Bertram is a 20-year veteran of IT. He's an automation engineer, blogger, consultant, freelance writer, Pluralsight course author and content marketing advisor to multiple technology companies. Adam also founded the popular TechSnips e-learning platform. He mainly focuses on DevOps, system management and automation technologies, as well as various cloud platforms mostly in the Microsoft space. He is a Microsoft Cloud and Datacenter Management MVP who absorbs knowledge from the IT field and explains it in an easy-to-understand fashion. Catch up on Adam's articles at adamtheautomator.com, connect on LinkedIn or follow him on Twitter at @adbertram or the TechSnips Twitter account @techsnips_io.

