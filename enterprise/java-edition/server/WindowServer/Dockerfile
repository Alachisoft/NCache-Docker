# Setting base image for NCache.
FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Paths for Visual C++ Redistributables that are prerequisites for NCache
ARG REDISTRIBUTABLE_2015_2022="https://aka.ms/vs/17/release/vc_redist.x64.exe"
ARG REDISTRIBUTABLE_2010="https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x64.exe"

ARG JAVA_VERSION=17

# Downloading and Installing JDK, and then deleting the downloaded file
RUN curl -SL --output java.exe https://download.oracle.com/java/%JAVA_VERSION%/latest/jdk-%JAVA_VERSION%_windows-x64_bin.exe \
    && java.exe /s \
    && del java.exe
    
# Setting JAVA_HOME environment variable at system level
RUN powershell -Command "[Environment]::SetEnvironmentVariable('JAVA_HOME', 'C:\Program Files\Java\jdk-%JAVA_VERSION%\', [System.EnvironmentVariableTarget]::Machine)"

# Downloading and Installing Visual C++ Redistributables and then deleting the downloaded files
RUN curl.exe --silent --location --output vsredist.exe %REDISTRIBUTABLE_2015_2022% \
    && vsredist.exe /norestart /q \
    && del vsredist.exe \
    && curl.exe --silent --location --output vsredist.exe %REDISTRIBUTABLE_2010% \
    && vsredist.exe /norestart /q \
    && del vsredist.exe
    
# Setting the working directory to copy setups and resources for configuring NCache
WORKDIR /app

# Make sure that a folder ("resources") exist in the same directory as the Dockerfile.
# Make sure that "StartUp.ps1" script resides in the "resources" folder.
# Make sure that NCache setup resides in the "resources" folder. It can be downloaded from https://www.alachisoft.com/download-ncache.html.
# Copying resources into the work directory of the container.
COPY resources .

# Exposing ports used by NCache for communication.
# Exposing port 9800 at which NCache service will listen for incoming client connection requests.
# Exposing the port 8250 at which NCache service will listen for incoming management connection requests (NCache Manager, Monitor and Tools).
# Exposing the port 9900 at which Bridge service will listen for incoming connection requests from cache processes.
# Exposing the port 8260 at which Bridge service will listen for incoming Management connection requests (NCache Manager and Tools).
# Exposing the port 8250-8260 for management operations.
# For more information about ports visit https://www.alachisoft.com/resources/docs/ncache/getting-started-guide-windows/open-firewall-tcp.html;
EXPOSE 8250-8260 9800 7800-7900 8300-8400 9900 10000-10100

# Installing NCache setup.
# The parameter "KEY" is the install key and is sent to user through e-mail once they download NCache setup. In case if user does not get a key, contact us at http://www.alachisoft.com/company/contact-us.html.
# The parameter "USERFIRSTNAME" represents the first name of the user.
# The parameter "USERLASTNAME" represents the last name of the user.
# The parameter "COMPANYNAME" represents the company the user works for.
# The parameter "EMAILADDRESS" represents the e-mail address of the user.
# The parameter "INSTALLDIR" and "TARGETDIR" represents the installation directory where NCache will be installed.
# The parameter "INSTALL_PLAYGROUND" specifies to install or not playground with NCache.
# The parameter "/qn" specifies that NCache will be installed silently without user interaction and will not prompt the user for anything.
RUN msiexec /i ncache.ent.java.msi KEY="XXXXXXXXX" USERFIRSTNAME="John" USERLASTNAME="Smith" COMPANYNAME="youcompany" EMAILADDRESS="john@yourdomain.com" TARGETDIR="C:\Program Files\NCache" INSTALLDIR="C:\Program Files\NCache" STARTCACHE="false" INSTALL_PLAYGROUND=false /qn \
 && del ncache.ent.java.msi

# Entry point for the container, once all the required configurations have been made.
ENTRYPOINT ["powershell.exe", "C:/app/Startup.ps1" ]