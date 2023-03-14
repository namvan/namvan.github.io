Original from here (https://blog.jsinh.in/man-002-tale-of-two-web-config-in-mvc/#.XEpNa1xLguU)

When creating a MVC project using Visual Studio you will observe that creation process will add two web.config files to your project.

![tale-of-two-webconfig-mvc-image](../images/tale-of-two-webconfig-mvc.png)

In root of the project folder.
In the root of the Views folder in the project folder.
Question:
The web.config in the root of the project is natural and expected, but why MVC project contains a web.config files in the views folder?

Answer:

To quote wikipedia:

A controller can send commands to the model to update the model's state (e.g., editing a document). It can also send commands to its associated view to change the view's presentation of the model (e.g., by scrolling through a document).

In ASP.NET MVC concept of routing is used that helps decoupling URLs mapping with specific files. Due to the routing definitions and route collection definitions of any application enables the application to serve a URL to a controller based on patterns identified in the URL.

The controller are therefore responsible to route your request based on the identified (and valid) pattern, do some operation on the model and return a rendered view based on the operation performed as response.

So logically if the view folder and view (webpages) are accessible or can be requested by user then the basic MVC pattern and practice followed by Microsoft will be violated.

This is prevented by adding a web.config and blocking access to view folder and files directly via user request or through URL.

web.config found in the views folder contains many sections, out of which following line of code serves the above described purpose:
`
<system.webServer>
  <handlers>
    <remove name="BlockViewHandler"/>
    <add
        name="BlockViewHandler"
        path="*"
        verb="*"
        preCondition="integratedMode"
        type="System.Web.HttpNotFoundHandler" />
  </handlers>
</system.webServer>
`
So keep access to the Views folder and files directly without routing through the controller following configuration and web.config in Views folder is required and important.