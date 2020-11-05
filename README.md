# Airon-DSC-Z2Base
Конфигурация Windows Desired State Configuration для установки комплекта ПО на машины для проведения трансляций.
Состав ПО:
- 7zip
- Google Chrome
- Драйверы BlackMagic
- VLC media player
- Zoom client
- VMIX

------------
Для применения конфигурации необходимо выполнить следующие шаги:
1.  Настроить WinRM командой `winrm quickconfig -force`
2. Запустить PowerShell от имени администратора и установить необходимые модули и скачать конфигурацию командами
```
Set-ExecutionPolicy RemoteSigned -Force
Install-Module cChoco -Force
Install-Module xPSDesiredStateconfiguration -Force
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/alexey-saveliev/Airon-DSC-Z2Base/main/mof/localhost.mof' -OutFile $env:temp\localhost.mof
```
3. Применить конфигурацию командой
```
Start-DscConfiguration -Path $env:temp -Force -Wait -Verbose
```
4. Вручную установить VMIX для чего запустить программу установки командой
```
. C:\TEMP\vmix23.exe
```
5. Если при применении конфигурации на шаге три возникали ошибки. повторно применить конфигурацию командой
```
Start-DscConfiguration -Path $env:temp -Force -Wait -Verbose
```
6. Перезагрузить компьютер и убедиться в работоспособности установленного ПО
