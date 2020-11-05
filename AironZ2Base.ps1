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
            DestinationPath = "$env:TEMP/vmix23.exe"
            URI = "http://telesto.dotserv.ru/vmix23.exe"            
        }

        xRemoteFile downloadBlackMagicDrivers {
            DestinationPath = "$env:TEMP/DesktopVideoInstaller.msi"
            URI = "http://telesto.dotserv.ru/Desktop Video Installer v11.6.msi"            
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
            Path = "$env:TEMP\DesktopVideoInstaller.msi"
            Arguments = "/norestart"
            Ensure = 'Present'
            ProductID = '79AA24FA-1930-4C63-9335-BB619FCA6B33'
            DependsOn = "[xRemoteFile]downloadBlackMagicDrivers"
        }
        
    }


}

AironZ2Base