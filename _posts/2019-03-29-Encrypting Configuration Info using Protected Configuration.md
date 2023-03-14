Protected configuration provides the capability to create, delete, export, and import RSA key containers when using the RsaProtectedConfigurationProvider. One scenario where this is useful is in a Web farm where the same encrypted Web.config file will be deployed to several servers. In that case, the same RSA key container must also be deployed to those servers. To accomplish this, you would create an RSA key container for the application, export it to an XML file, and import it on each server that needs to decrypt the encrypted Web.config file.

Creating RSA key containers can also be useful on a single Web server that hosts multiple ASP.NET applications. By creating an RSA key container for each application or for each set of applications for a single customer, you can improve the security of an application's sensitive configuration information by ensuring that the Web.config file for one application cannot be decrypted using the RSA key container from another application.

More details is here <https://docs.microsoft.com/en-us/previous-versions/aspnet/yxw286t2%28v%3dvs.100%29>

or here <https://docs.microsoft.com/en-us/previous-versions/aspnet/yxw286t2%28v%3dvs.100%29>