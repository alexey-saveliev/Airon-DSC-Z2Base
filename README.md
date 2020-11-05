# Airon-DSC-Z2Base
```
winrm quickconfig -force
```
```
Set-ExecutionPolicy RemoteSigned -Force
Install-Module cChoco -Force
Install-Module xPSDesiredStateconfiguration -Force
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/alexey-saveliev/Airon-DSC-Z2Base/main/mof/localhost.mof' -OutFile $env:temp\localhost.mof
Start-DscConfiguration -Path $env:temp -Force -Wait -Verbose
```
```
. $env:temp\vmix23.exe
```