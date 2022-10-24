# Setting base image for NCache. Uses Windows Server Core.
FROM mcr.microsoft.com/windows/servercore:ltsc2022
# Setting work directory to copy setups and resources for configuring NCache.
WORKDIR /app

# Make sure that a folder ("resources") exist in the same directory as the Dockerfile.
# Make sure that "IPBinding.ps1" script resides in the "resources" folder.
# Make sure that ".NET 6.0" resides in the "resources" folder.
# Make sure that "jdk" installer resides in the "resources" folder if you want to use NCache java server side feature.
# Make sure that NCache setup resides in the "resources" folder. It can be downloaded from https://www.alachisoft.com/download-ncache.html.
# Copying resources into the work directory of the container.
COPY resources .

# Exposing ports used by NCache for communication.
# Exposing port 9800 at which NCache service will listen for incoming client connection requests.
# Exposing the port 8250 at which NCache service will listen for incoming management connection requests (NCache Manager, Monitor and Tools).
# Exposing the port 8250-8260 for management operations.
# For more information about ports visit https://www.alachisoft.com/resources/docs/ncache/getting-started-guide-windows/open-firewall-tcp.html;
EXPOSE 8250-8260 9800 7800-7900 8300-8400 

#installing the .NET 6.0 runtime.
#.NET 6.0 can be downloaded from https://dotnet.microsoft.com/en-us/download/dotnet.
RUN "powershell.exe Start-Process -Filepath "<Filepath to .NET 6.0 from resources folder>" -NoNewWindow -Wait -PassThru -ArgumentList '/s'; \
Remove-Item 'Filepath to .NET 6.0 in working directory';"

# Installing NCache setup.
# The parameter "KEY"(optional) is the install key and is sent to user through e-mail once they download NCache setup. In case if user does not get a key, contact us at http://www.alachisoft.com/company/contact-us.html.
# The parameter "USERFIRSTNAME" represents the first name of the user.
# The parameter "USERLASTNAME" represents the last name of the user.
# The parameter "COMPANYNAME" represents the company the user works for.
# The parameter "EMAILADDRESS" represents the e-mail address of the user.
# The parameter "INSTALLDIR" and "TARGETDIR" represents the installation directory where NCache will be installed.
# The parameter "/qn" specifies that NCache will be installed silently without user interaction and will not prompt the user for anything.
RUN msiexec /i ncache.ent.net.x64.msi INSTALLMODE="3" USERFIRSTNAME="John" USERLASTNAME="Smith" COMPANYNAME="youcompany" EMAILADDRESS="john_smith@yourdomain.com" TARGETDIR="C:\Program Files\NCache" INSTALLDIR="C:\Program Files\NCache" STARTCACHE="false" /qn

RUN "powershell.exe Remove-Item C:/app/ncache.ent.net.x64.msi"

# Entry point for the container, once all the required configurations have been made.
ENTRYPOINT ["powershell.exe", "C:/app/StartUp.ps1" ]