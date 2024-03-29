---
layout: post
date:   2022-06-13 01:01:01 +1100
categories: 
---

Developing Extensions for SSMS 2016
===================================
Original content is [here](https://www.sqlservercentral.com/Forums/Topic1802009-3740-1.aspx)

SSMS Schema Folders (https://ssmsschemafolders.codeplex.com/) is an extension for SQL Server Management Studio 2012, 2014 and 2016. It groups sql objects in Object Explorer (tables, views, etc.) into schema folders.

Using Visual Studio 2015, create a VSIX project. `Templates > Visual C# (or Visual Basic) > Extensibility > VSIX Project`
There should be the option to install the Visual Studio 2015 SDK if it is not already installed.
Next add a VSPackage. `Right click on project > Add > New Item... > Extensibility > VSPackage > Visual Studio Package`
As a sample, add a Custom Command. Same as the VSPackage above. This will add a menu item to the tools menu so that we can see SSMS loads the extension.
More details can be found at https://msdn.microsoft.com/en-us/library/bb166030.aspx

When we build the project, it will create the project .dll and .pkgdef. We can ignore everything else in there for the moment. It is possible to stop it from outputting the extra files.

Copy the project .dll and .pkgdef files into a sub folder in the SSMS extensions folder. `C:\Program Files (x86)\Microsoft SQL Server\130\Tools\Binn\ManagementStudio\Extensions`

If you tried to run SSMS now, it will attempt to verify the extension and silently fail. We can force it to skip this by adding the registry setting below. Replace the 0's with your package guid. Make sure to keep the curly brackets.
Note this is only meant for development. When they release official support for extensions then this should no longer be required.

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\SQL Server Management Studio\13.0\Packages\{00000000-0000-0000-0000-000000000000}]
"SkipLoading"=dword:1

If you run SSMS now you should see your sample menu item.

Now the problem is that if your extension loads correctly, it will remove the registry setting. We can restore the registry setting when SSMS exits by adding the following code to the package class.

```
protected override int QueryClose(out bool canClose)
{
    UserRegistryRoot.CreateSubKey(@"Packages\{" + PackageGuidString + "}").SetValue("SkipLoading", 1);
    return base.QueryClose(out canClose);
}
```

This does have the downside of it not loading when running multiple instances of SSMS. You can work around this by using a timer to set the reg key shortly after the Initialize() method.

You now have an extension that will load in SSMS.

If you want your extension to work with sql related features then you are going to need to add references to some SSMS dll files. The first one to add is SqlWorkbench.Interfaces.dll located in the ManagementStudio folder. This contains a lot of interfaces that you can work with. The next one you may want to add is SqlPackageBase.dll. This contains some GUIDs that will be useful for the package ProvideAutoLoad attribute.

If you want to go deeper then you can use a tool like ILSpy or Reflector. I would start with the dll files in the Extensions\Application folder.

The above method will also work with SSMS 2012 and 2014 but you need to be aware of two things. You must reference the correct version of all the dll files and the reg key is in a slightly different location.
For the references you will need to create a separate project for each SSMS version.
For the reg key the 2012 version is in \11.0\ and 2014 in \12.0\.

If you are having trouble with your extension loading, then start SSMS with the `-log logfilename.xml` parameter. It will log details to `%AppData%\Microsoft\AppEnv\14.0\ActivityLog.xml`. Search the file for your package guid to find the relevant information.

