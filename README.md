# Airon-DSC-Z2Base
������������ Windows Desired State Configuration ��� ��������� ��������� �� �� ������ ��� ���������� ����������.
������ ��:
- 7zip
- Google Chrome
- �������� BlackMagic
- VLC media player
- Zoom client
- VMIX

------------
��� ���������� ������������ ���������� ��������� ��������� ����:
1.  ��������� WinRM �������� `winrm quickconfig -force`
2. ��������� PowerShell �� ����� �������������� � ���������� ����������� ������ � ������� ������������ ���������
```
Set-ExecutionPolicy RemoteSigned -Force
Install-Module cChoco -Force
Install-Module xPSDesiredStateconfiguration -Force
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/alexey-saveliev/Airon-DSC-Z2Base/main/mof/localhost.mof' -OutFile $env:temp\localhost.mof
```
3. ��������� ������������ ��������
```
Start-DscConfiguration -Path $env:temp -Force -Wait -Verbose
```
4. ������� ���������� VMIX ��� ���� ��������� ��������� ��������� ��������
```
. C:\TEMP\vmix23.exe
```
5. ���� ��� ���������� ������������ �� ���� ��� ��������� ������. �������� ��������� ������������ ��������
```
Start-DscConfiguration -Path $env:temp -Force -Wait -Verbose
```
6. ������������� ��������� � ��������� � ����������������� �������������� ��
