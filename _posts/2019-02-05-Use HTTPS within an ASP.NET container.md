Original post from here <https://www.danielemaggio.eu/containers/iis-ssl-docker/>

# Requirements
1. SSL Certificate in the form of .pfx file (myCertificate.pfx in the script)
2. IIS

# Use a real SSL
The Powershell script as below will install the certificate and expose 443 for HTTPS

    $securePfxFile = c:\inetpub\wwwroot\myCertificate.pfx
    $securePfxPass = [Environment]::GetEnvironmentVariable("CERT_PASS") | ConvertTo-SecureString -AsPlainText -Force
    Import-PfxCertificate -Password $securePfxPass -CertStoreLocation Cert:\LocalMachine\My -FilePath $securePfxFile
    
    $pfxThumbprint = (Get-PfxData -FilePath c:inetpubwwwrootmyCertificate.pfx -Password $securePfxPass).EndEntityCertificates.Thumbprint
    
    $binding = New-WebBinding -Name "Default Web Site" -Protocol https -IPAddress * -Port 443;
    $binding = Get-WebBinding -Name "Default Web Site" -Protocol https;
    $binding.AddSslCertificate($pfxThumbprint, "my");
    
    #You should remove both the PFX password from the Environment Variable and the .pfx file
    [Environment]::SetEnvironmentVariable("CERT_PASS",$null)

# Use a self-signed SSL instead
Original post from here <https://blogs.msdn.microsoft.com/zxue/2016/12/19/adding-https-support-to-individual-windows-containers-using-self-issued-certificates/>
The Powershell script as below will create one then install it and make it ready to serve

    import-module webadministration
    #Get-Module -ListAvailable
    
    cd cert:
    $cert = New-SelfSignedCertificate -DnsName  myweb -Friendlyname MyCert -CertStoreLocation Cert:\LocalMachine\My
    $rootStore = New-Object System.Security.Cryptography.X509Certificates.X509Store -ArgumentList Root, LocalMachine
    $rootStore.Open("MaxAllowed")
    $rootStore.Add($cert)
    $rootStore.Close()
    
    cd iis:
    new-item -path IIS:SslBindings\0.0.0.0!443 -value $cert
    New-WebBinding -Name "Default Web Site" -IP "*" -Port 443 -Protocol https
    iisreset

