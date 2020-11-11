# Setting base image for NCache.
FROM microsoft/dotnet-framework:4.7.2-runtime

# Setting work directory to copy setups and resources for configuring NCache.
WORKDIR /app

# Make sure that the 2 folders ("resources" and "setup") exist in the same directory as the Dockerfile.
# Make sure that "IPBinding.ps1" script resides in the "resources" folder.
# Make sure that Microsoft Visual C++ 2010 x64 Redistributable setup is placed in the "setup" folder. It can be downloaded from https://www.microsoft.com/en-us/download/details.aspx?id=14632.
# Make sure that NCache setup resides in the "setup" folder. It can be downloaded from http://www.alachisoft.com/download-ncache.html.
# Copying resources and setups into the work directory of the container.
COPY resources .
COPY setup .

# Exposing ports used by NCache for communication.
# Exposing port 9800 at which NCache service will listen for incoming client connection requests.
# Exposing port 8250 at which NCache service will listen for incoming management connection requests (NCache Manager, Monitor and Tools).
EXPOSE 9800 8250 

# Installing Microsoft Visual C++ 2010 x64 Redistributable (Prerequisite of NCache).
RUN vcredist_x64.exe /norestart /q

# Installing NCache setup.
# The parameter "USERFIRSTNAME" represents the first name of the user.
# The parameter "USERLASTNAME" represents the last name of the user.
# The parameter "COMPANYNAME" represents the company the user works for.
# The parameter "EMAILADDRESS" represents the e-mail address of the user.
# The parameter "INSTALLDIR" represents the installation directory where NCache will be installed.
# the parameter "/qn" specifies that NCache will be installed silently without user interaction and will not prompt the user for anything.
RUN msiexec /i ncache.oss.x64.msi USERFIRSTNAME="abc" USERLASTNAME="xyz" COMPANYNAME="yourcompany" EMAILADDRESS="abc@yourdomain.com" INSTALLDIR="C:\Program Files\NCache" /qn

# Currently, the IP during NCache installation is stored in the configuration files and it can not be made static at that point.
# However, the IP can be made static once the container is started.
# An IP Binding change task is scheduled to run when the container instance is started. This task replaces the IP with the actual IP assigned to the container.
# Creating one time executing IP Binding task that will change the IP in NCache Configuration files on the first time the container is started.
RUN C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy UnRestricted -File "C:\app\CreateScheduledTasks.ps1"

# Entry point for the container, once all the required configurations have been made.
CMD start -Verbose