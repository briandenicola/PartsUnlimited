FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2022

# ARG PASS
# ARG CERT

RUN md c:\aspnet-startup
COPY *.ps1 c:/aspnet-startup/

WORKDIR /inetpub/wwwroot
COPY publish .
#COPY $CERT .

# RUN powershell.exe -Command \
#   Import-Module WebAdministration; \
#   $site = 'Default Web Site'; \
#   $certStore = 'Cert:\LocalMachine\My'; \
#   $secure = ConvertTo-SecureString -String $ENV:PASS -AsPlainText -Force; \
#   $cert = Import-PfxCertificate -FilePath $ENV:CERT -CertStoreLocation $certStore -Password $secure; \
#   New-WebBinding -Name $site -IP * -Port 443 -Protocol https; \
#   $binding = Get-WebBinding -Name $site -Protocol https; \
#   $binding.AddSslCertificate( $cert.Thumbprint, 'My' ); \
#   Remove-Item $ENV:CERT -Force 

ENTRYPOINT ["powershell.exe", "c:\\aspnet-startup\\Startup.ps1"]