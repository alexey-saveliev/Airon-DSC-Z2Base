<#

Set-ExecutionPolicy RemoteSigned
winrm quickconfig

Start-DscConfiguration -Path C:\bin\AironZ2Base\AironZ2Base -Force -Wait -Verbose

#>


Configuration AironZ2Base {
    Import-DSCResource -Module cChoco
    Import-DscResource –ModuleName "PSDesiredStateConfiguration"
    Import-DscResource -ModuleName "xPSDesiredStateConfiguration"

    Node localhost {
        cChocoInstaller installChoco {
            InstallDir = "$env:ProgramData\chocolatey"
        }
                
        xRemoteFile downloadVMIX {
            DestinationPath = 'C:\TEMP\vmix23.exe'
            URI = "http://softserv.ru/packages/vmix23.exe"            
        }

        
        xRemoteFile downloadBlackMagicDrivers {
            DestinationPath = 'C:\TEMP\DesktopVideoInstaller.msi'
            URI = "http://softserv.ru/packages/Desktop_Video_Installer_v11.6.msi"            
        }
        
        cChocoPackageInstallerSet installBaseSoftware {
            Name        = @(
                            "7zip"
                            "dotnet3.5"
                            "googlechrome"
                            "vlc"
                            "zoom"
                           )
            Ensure      = 'Present'
            DependsOn   = "[cChocoInstaller]installChoco"            
        }

        xPackage installBlackMagicDrivers {
            Name = 'Blackmagic Desktop Video'
            Path = 'C:\TEMP\DesktopVideoInstaller.msi'
            Arguments = "/norestart"
            Ensure = 'Present'
            ProductID = '79AA24FA-1930-4C63-9335-BB619FCA6B33'
            DependsOn = "[xRemoteFile]downloadBlackMagicDrivers"
        }
        
    }


}

AironZ2Base -Out .\mof\