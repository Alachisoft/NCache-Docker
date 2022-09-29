# Setting base image for NCache. Uses Windows Server Core.
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Setting work directory to copy setups and resources for configuring NCache.
WORKDIR /app

# Make sure that the 2 folders ("resources" and "setup") exist in the same directory as the Dockerfile.
# Make sure that "IPBinding.ps1" script resides in the "resources" folder.
# Make sure that Microsoft Visual C++ 2010 x64 Redistributable, dotnet sdk for 6.0 and jdk's setup is placed in the "setup" folder. Microsoft Visual C++ 2010 x64 Redistributable can be downloaded from https://www.microsoft.com/en-us/download/details.aspx?id=14632.
# Make sure that NCache setup resides in the "setup" folder. It can be downloaded from http://www.alachisoft.com/download-ncache.html.
# Copying resources and setups into the work directory of the container.
COPY resources .
COPY setup .

# Exposing ports used by NCache for communication.
# Exposing port 9800 at which NCache service will listen for incoming client connection requests.
# Exposing the port 8250 at which NCache service will listen for incoming management connection requests (NCache Manager, Monitor and Tools).
# Exposing the port 9900 at which Bridge service will listen for incoming connection requests from cache processes.
# Exposing the port 8260 at which Bridge service will listen for incoming Management connection requests (NCache Manager and Tools).
# Exposing the port 8251 at which web manager will listen.
EXPOSE 8250-8260 9800 7800-7900 8300-8400 9900 10000-10100

# Installing Microsoft Visual C++ 2010 x64 Redistributable (Prerequisite of NCache).
RUN vcredist_x64.exe /norestart /q

#installing the Dotnet core 6.0 runtime.
RUN "c:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe Start-Process -filepath dotnet-sdk-6.0.100-win-x64.exe -NoNewWindow -Wait -PassThru -ArgumentList '/s'"

# Installing Java-11 (Prerequisite of NCache java server side feature).
 RUN "c:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe Start-Process -filepath jdk-11.0.11_windows-x64_bin.exe -NoNewWindow -Wait -PassThru -ArgumentList '/s'"
# Installing NCache setup.
# The parameter "INSTALLMODE" represents the NCache installation mode and has the following values:
# Rename this parameter to "EDITION" if you are building image for NCache version 4.8 or older.
#		Enterprise Server Install mode = "0"
#		Enterprise Remote Client Install mode = "3"
# The parameter "KEY" is the install key and is sent to user through e-mail once they download NCache setup. In case if user does not get a key, contact us at http://www.alachisoft.com/company/contact-us.html.
# The parameter "USERFIRSTNAME" represents the first name of the user.
# The parameter "USERLASTNAME" represents the last name of the user.
# The parameter "COMPANYNAME" represents the company the user works for.
# The parameter "EMAILADDRESS" represents the e-mail address of the user.
# The parameter "INSTALLDIR" represents the installation directory where NCache will be installed.
# the parameter "/qn" specifies that NCache will be installed silently without user interaction and will not prompt the user for anything.
RUN msiexec /i ncache.ent.x64.msi INSTALLMODE="0" KEY="XXXXXXXXXX" USERFIRSTNAME="abc" USERLASTNAME="xyz" COMPANYNAME="youcompany" EMAILADDRESS="abc@yourdomain.com" TARGETDIR="C:\Program Files\NCache" INSTALLDIR="C:\Program Files\NCache" STARTCACHE="false" /qn 

# Currently, the IP during NCache installation is stored in the configuration files and it can not be made static at that point.
# However, the IP can be made static once the container is started.
# An IP Binding change task is scheduled to run when the container instance is started. This task replaces the IP with the actual IP assigned to the container.
# Creating one time executing IP Binding task that will change the IP in NCache Configuration files on the first time the container is started.
SHELL ["powershell"]
RUN Remove-Item C:/app/jdk-11.0.11_windows-x64_bin.exe
RUN Remove-Item C:/app/vcredist_x64.exe -Force 
RUN Remove-Item c:/app/ncache.ent.net.x64.msi
RUN Remove-Item c:/app/dotnet-sdk-6.0.100-win-x64.exe 

# Entry point for the container, once all the required configurations have been made.
ENTRYPOINT ["powershell.exe", "C:/app/IpBinding.ps1" ]