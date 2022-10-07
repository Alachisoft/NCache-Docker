Set-ExecutionPolicy Unrestricted -Force
#::-----------------------------------------------------------------------
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

$installDir = ${env:NCHOME};
$config = "config\";
$service = "bin\service";

$path = Join-Path -Path (Join-Path -Path $installDir -ChildPath $service) -Childpath "Alachisoft.NCache.Service.dll.config";
$xml = [xml](Get-Content $path)
$oldIP = ($xml.configuration.appSettings.add | Where-Object {$_.key -eq "NCacheServer.BindToIP"} | Select value) | Select -ExpandProperty "value"
$newIP = $ipaddress = $(ipconfig | where {$_ -match 'IPv4.+\s(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})' } | out-null; $Matches[1]);

#::-----------------------------------------------------------------------
Write-Host "";
Write-Output "CHANGING CONFIGURATIONS";
$path = Join-Path -Path (Join-Path -Path $installDir -ChildPath $config) -Childpath "client.ncconf";
(Get-Content $path) | Foreach-Object {$_ -replace , $oldIP, $newIP}  | Out-File $path

$path = Join-Path -Path (Join-Path -Path $installDir -ChildPath $config) -Childpath "config.ncconf";
(Get-Content $path) | Foreach-Object {$_ -replace , $oldIP, $newIP}  | Out-File $path

$path = Join-Path -Path (Join-Path -Path $installDir -ChildPath $service) -Childpath "Alachisoft.NCache.Service.dll.config";
(Get-Content $path) | Foreach-Object {$_ -replace , $oldIP, $newIP}  | Out-File $path

Write-Host "Configurations are modified successfully.";


Write-Host "Starting NCache SVC.";
Start-Service -Name NCacheSvc;
Write-Host "Started NCache SVC";

Start-NCacheWebManagementProcess;

Set-ExecutionPolicy RemoteSigned -Force

# this script deletes itself.
Remove-Item $MyINvocation.InvocationName
