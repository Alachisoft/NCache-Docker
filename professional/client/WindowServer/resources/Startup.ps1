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
Stop-Service -Name NCacheSvc;
Write-Host "";
Write-Output "CHANGING CONFIGURATIONS";
$path = Join-Path -Path (Join-Path -Path $installDir -ChildPath $config) -Childpath "client.ncconf";
(Get-Content $path) | Foreach-Object {$_ -replace , $oldIP, $newIP}  | Out-File $path

$path = Join-Path -Path (Join-Path -Path $installDir -ChildPath $config) -Childpath "config.ncconf";
(Get-Content $path) | Foreach-Object {$_ -replace , $oldIP, $newIP}  | Out-File $path

$path = Join-Path -Path (Join-Path -Path $installDir -ChildPath $service) -Childpath "Alachisoft.NCache.Service.dll.config";
(Get-Content $path) | Foreach-Object {$_ -replace , $oldIP, $newIP}  | Out-File $path

Write-Host "Configurations are modified successfully.";

# Define the registry key path and value to set
$registryPath = "HKLM:\SOFTWARE\Alachisoft\NCache"
$registryValueName = "InstallType" 
$newRegistryValueData = "dci" 

# Set the registry value
Set-ItemProperty -Path $registryPath -Name $registryValueName -Value $newRegistryValueData
# Optionally, verify that the value has been set
$updatedValue = (Get-ItemProperty -Path $registryPath).$registryValueName
if ($updatedValue -eq $newRegistryValueData) {
	Write-Host "Registry value '$registryValueName' has been successfully updated to '$newRegistryValueData'."
} else {
	Write-Error "Failed to update the registry value."
}	

Write-Host "Starting NCache SVC.";
Start-Service -Name NCacheSvc;
Write-Host "Started NCache SVC";

while ($true) {
	Start-Sleep -Seconds 500
}
