https://exceptionnotfound.net/whats-this-and-can-i-delete-it-examining-a-default-asp-net-mvc-project/

I have a two-step process that I utilize whenever I have to dive into a code project that I didn't create. For each file, folder, NuGet package, etc. I examine the item in question and ask myself the following questions:

What is this?
Can I delete it?
See, I'm a deletionist. I would much prefer to delete all code ever written, because then it will never break. But, given that I live in the real world, that's not possible, so I settle for the best alternative: deleting anything that isn't found to have a reason to exist, often with extreme prejudice.

An airman drives a sledgehammer through a car window 

I work mostly in the ASP.NET world, and given that my team is in the process of starting a greenfield project I thought it might be useful to examine a brand-new ASP.NET MVC project with those same two questions in mind. So, we're gonna do just that.

Let's take a look at a default ASP.NET MVC application (created with ASP.NET 4.7 and Visual Studio 2017) and see if we can live without some of the files, folders, and NuGet packages that are included by default.

Folders and Files
Here's a screenshot of our default MVC project, and the folders and files it created.

The folders and files in a default ASP.NET MVC application

Let's walk through each of these folders and files and see if we can determine which ones we actually need.

App_Data
New sample projects often begin with an empty App_Data folder. In theory, this is so you can place items like Entity Framework data contexts and generated models in this folder. In practice, however, you most likely will be moving those items to another place in the project structure, which may be a .Lib or .Core project. Can I delete it? YES

App_Start
This folder comes equipped with three files: BundleConfig, FilterConfig, and RouteConfig. Each of these files does something to help ASP.NET MVC set up a project:

BundleConfig.cs allows programmers to specify "bundles" of CSS and JS files. The reason we do this is primarily to allow ASP.NET to minify and bundle files, thus reducing the total data sent over a network and the total number of network requests respectively. If, however, you already have minified files or want to use another bundling/minification system like Gulp, you can remove it. Can I delete it? YES
FilterConfig.cs allows us to specify action filters that apply to our global project. As with other files in this folder, you can pretty easily set this up in the Global file, though there's not really a better place for it than where it is. Can I delete it? YES BUT, you probably won't want to.
RouteConfig.cs allows developers to tell ASP.NET how to handle routing, whether by convention or using attributes. If you're using attribute routing (which I HIGHLY recommend) then you must initialize the attribute routing somewhere, either here or in the Global.asax file. Can I delete it? YES BUT you shouldn't.
Content
The Content folder is meant to contain CSS files. You'll want to use this folder for its intended purpose, because it enables a specific Razor feature @Url.Content. By default there's a few files already in this folder.

bootstrap.css and bootstrap.min.css: The Bootstrap styles and the corresponding minified version of that file. If you're not using Bootstrap, you'll want to remove these. Can I delete it? YES.
site.css: Meant to hold any styles that are unique to your project. If you want to use this file, you can, but you could also just as easily add more CSS files to this folder. Can I delete it? YES.
Controllers
The Controllers folder will only have one file in it, HomeController.cs, and it just contains a few sample Actions that could be useful to someone who is just getting started with ASP.NET MVC. Can I delete this file? YES. However, you absolutely do NOT want to remove the folder Controllers, because its existence is how ASP.NET MVC works in 99.99% of all apps. Can I delete this folder? NO.

fonts
The only reason this folder exists is because Bootstrap is included by default, and that's probably also why it doesn't match the naming conventions of the rest of the solution (why is the F not capitalized?) Can I delete it? YES if you aren't going to use Bootstrap.

Models
This is included into the default project and is empty for a similar reason to App_Data. In theory, you will include things like data models or view models here. In practice, you're almost always going to put those files somewhere else, like in your .Lib or .Core project or in a dedicated ViewModels folder. Can I delete it? YES

Scripts
This folder is exactly what it sounds like; it contains several JavaScript files and is meant to be the single repository for all such files. The unique thing about this folder is that, in the default project, all of its files are tied to NuGet packages, which consequently means they will be removed if the corresponding package is removed. Can I delete this folder? YES BUT DON'T as this is a very handy way of storing JS files.

Views
Another folder that is exactly what it sounds like: a place for storing .cshtml view files. Pretty much everything in this folder can be deleted, with two exceptions:

The _ViewStart.cshtml file. Technically you can delete this file but you won't want to. This file sets a "default" layout that all other views use unless they specify another. Can I delete this? YES BUT DON'T
The web.config file. This file does something very important; it sets up the configuration of your .cshtml files, it prevents IIS from serving up those files directly, and it specifies what namespaces the .cshtml files can use. Can I delete this? YES BUT DON'T unless you don't need the Razor/cshtml functionality at all.
ApplicationInsights.config
Exactly what it sounds like: the configuration file for ApplicationInsights. Can I delete it? YES if you're not using ApplicationInsights.

favicon.ico
The default favicon for the site. Can I delete it? YES but it's a good idea to replace it with some other favicon.

Global.asax
This file is responsible for initializing ASP.NET MVC projects. You can use other setups for managing this kind of flow, but unless you're doing one of those you probably don't want to remove this file. Can I delete it? NO except in specific circumstances.

packages.config
This XML file works with NuGet to determine which packages to include in your project. Can I delete it? NO.

web.config
This is the configuration file for your entire site. ASP.NET MVC requires this file to exist. Can I delete it? NO.

NuGet Packages
A default ASP.NET MVC project also includes a whole bunch of NuGet packages that may or may not be what you want. Here's a rundown of those packages, as well as whether or not we can delete them and what we might lose by doing so.

Antlr
Immediately we find a package which is included in the project because it is a dependency in another package. In this case, Antlr (ANother Tool for Language Recognition) is a dependency of the WebGrease package below, which in turn is a dependency for Microsoft.AspNet.Web.Optimization. Consequently, you can only remove this package if you can also remove the packages that are dependent on it. Can I delete this? YES if you don't need and remove those other packages first.

bootstrap
This package includes the Twitter Bootstrap front-end design framework. If you want to use it (and it is pretty simple to get started with it) go ahead, but otherwise take it out. Can I delete it? YES.

jQuery
jQuery is the front-end JavaScript framework, the one that everybody has heard of. And because it is so popular, it's also got other packages which are dependent on it, specifically Microsoft.jQuery.Unobtrusive.Validation and jQuery.Validation. If you can remove those packages, you can also remove this one (and dramatically clean up your Scripts folder in the process). Can I delete it? YES BUT only if you remove the dependencies first.

jQuery.Validation
This is a useful plugin for jQuery which enables client-side validation. If you're not going to use that feature (or are going to use a different framework for it) you can safely remove this package, at least, once you remove the package Microsoft.jQuery.Unobtrusive.Validation which has a dependency on this one. Can I delete it? YES BUT you must remove the Unobtrusive Validation package first.

Microsoft.ApplicationInsights.*
I confess that I have basically zero experience with this package, so take this paragraph with a grain of salt. ApplicationInsights is "an extensible Application Performance Management (APM) service for web developers" according to the official docs. This toolset allows you to monitor your live web applications and construct reports and views from that data. Can I delete it? YES

Microsoft.AspNet.Mvc
This package includes all the scaffolding and other code you need to make an ASP.NET MVC web application. Needless to say, you don't want to remove it. Can I delete it? NO unless you don't want to be using MVC anymore.

Microsoft.AspNet.Razor
This package is a bit confusing. The description reads "This package contains the runtime assemblies for ASP.NET Web Pages" which tells me that if I'm not using Web Pages then I can remove it. And yet, both the MVC package and the below WebPages package have a dependency on it, so now it's impossible for me to say whether or not you can delete it, even though it's probably not a good idea. Let's go with this: Can I delete it? PROBABLY NOT but I'd be interested to hear from anyone who did.

Microsoft.AspNet.Web.Optimization
Remember the BundleConfig.cs file from earlier in the App_Start folder? This is the package that actually does the bundling and minification set up by that file. It's also the package that has dependencies on WebGrease and Antlr, so if you're going to use a different method to bundle and/or minify, you're safe to remove this package. Can I delete it? YES.

Microsoft.AspNet.WebPages
The description for this package is just as confusing as the Razor one: "This package contains core runtime assemblies shared between ASP.NET MVC and ASP.NET Web Pages." Once again, we probably shouldn't delete this, even if we have no plans to use Web Pages. Can I delete it? PROBABLY NOT.

Microsoft.CodeDom.Providers.DotNetCompilerPlatform
This package enables compilation of ASP.NET projects using the .NET Compiler Platform, which is popularly known by its code name "Roslyn". You can remove this, but modern C# basically requires it, and so I would have to say Can I delete it? YES BUT DON'T except in very specific circumstances (e.g. deploying to older IIS where Roslyn won't be installed).

Microsoft.jQuery.Unobtrusive.Validation
This is a Microsoft-written package that integrates with jQuery to provide simple client-side validation for MVC projects. As with many of the other front-end packages, if you're not going to use this feature, you don't need this package. Can I delete it? YES.

Microsoft.Net.Compilers
This package allows .NET projects to compile without relying on the .NET Framework or Visual Studio existing on the target machine. It is incredibly useful. Can I delete this? YES BUT DON'T.

Microsoft.Web.Infrastructure
This particular package appears to be an interesting case. It allows us to dynamically register HTTP modules at runtime per the description, but searching for it yields several questions which imply that missing this package can cause several issues. Given that the package was published in 2011 and it comes pre-installed, I'm afraid I have to say Can I delete this? NO.

Modernizr
Modernizr is an absolutely fantastic little library that helps you detect if the browser your application is running in supports more advanced features of HTML5 and CSS3. The default project doesn't actually use this package anywhere (despite comment references to it in Bootstrap, Respond, and the BundleConfig.cs file), so Can I delete this? YES BUT you probably won't want to.

Newtonsoft.Json
This package is the king of all JSON-parsing packages. Given the prevalence of Web API systems and the simplicity of JSON (as compared to, say, XML) you will probably want to use this package at some point, but nothing prevents you from removing it from the default project. Can I delete this? YES

Respond
A tiny JS library designed to handle CSS Media Queries running on older versions of Internet Explorer. Can I delete this? YES BUT only if you don't care about looking nice in older versions of Internet Explorer.

WebGrease
WebGrease is a suite of tools used to optimize JavaScript, CSS, and image files. The Microsoft.AspNet.Web.Optimization package from earlier has a dependency on it, and that package is largely responsible for bundling and minification (though you can easily get WebGrease to do other tasks as well). Consequently, Can I delete it? YES BUT only if you also remove the Optimization package.

Summary
Sometimes it is useful to know exactly what we can and cannot delete, because the best code is often no code at all. A great many of the folders, files, and packages in a default ASP.NET MVC project can be deleted under the right conditions.

In my opinion, here's the minimum items you need to KEEP in order to have a reasonably-functional but bare bones ASP.NET MVC project:

App_Start folder
RouteConfig.cs
Content folder
Controllers folder
Scripts folder
Views folder
_ViewStart.cshtml file
web.config file (in Views folder)
Global.asax
web.config (in root folder)
packages.config
Microsoft.AspNet.Mvc package
Microsoft.AspNet.Razor package
Microsoft.AspNet.WebPages package
Microsoft.Web.Infrastructure package
How about you? What do you think you need to keep from the defaults for your ASP.NET MVC projects? Does my two-step methodology (what is this and can I delete it?) work for you? Am I totally off my rocker? Share in the comments!

Happy Coding!