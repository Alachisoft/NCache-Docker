# Creating One time executing IP Binding task that will change the IP in the NCache Configuration files on the first time the container is started.
schtasks /create /TN IPBinding /SC ONSTART /TR "c:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe C:\app\IPBinding.ps1" /ru SYSTEM
