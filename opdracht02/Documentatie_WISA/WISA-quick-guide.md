# WISA - A quick guide to create and configure a windows 2016 base box
*Authors: Nathan Cammerman, Matthias Van De Velde*

# Requirements
1. Virtualbox
2. Windows 2016 ISO
3. Vagrant
4. A will to live


# Create a new VM in Virtualbox
## Minimum settings  
* RAM: 2048 Mb  
* CPU: 1 processor  
* Adapter1: NAT  
* Attached ISO to virtual optical drive  

# Installation process
When it presents you the option to choose an operating system to install, choose Windows Server 2016 with Desktop experience.  

Choose a password like Admin2019. (we'll be changing this afterwards)  

# Preparing the image
## Install Guest Additions
1. Insert Guest Additions CD Image
2. Navigate to Windows Explorer -> This PC
3. Click on the Disk drive with the Guest Additions and double click the appropriate installation executable file

## Configuring the vagrant user
1. Run gpedit from a command prompt
2. Navigate to Computer Configuration -> Windows Settings -> Security Settings -> Account Policies -> Password Policy
3. Select 'Password must meet complexity requirements' and disable

4. Open a powershell prompt and paste the following (This will rename Administrator to vagrant while also setting the password to vagrant)

```Powershell
$admin=[adsi]"WinNT://./Administrator,user"
$admin.psbase.rename("vagrant")
$admin.SetPassword("vagrant")
$admin.UserFlags.value = $admin.UserFlags.value -bor 0x10000
$admin.CommitChanges()
```

## Configure WinRM(normal prompt)
```Powershell
winrm quickconfig -q
winrm set winrm/config/winrs @{MaxMemoryPerShellMB="512"}
winrm set winrm/config @{MaxTimeoutms="1800000"}
winrm set winrm/config/service @{AllowUnencrypted="true"}
winrm set winrm/config/service/auth @{Basic="true"}
sc config WinRM start= auto
```

## Disable Server Manager on startup
Go to Server Manager  
-> Manage  
-> Server ManagerProperties  
-> Tick the box
-> Ok

## Allow Remote Desktop connections
```Powershell
$obj = Get-WmiObject -Class "Win32_TerminalServiceSetting" -Namespace root\cimv2\terminalservices
$obj.SetAllowTsConnections(1,1)
```

## Disable UAC
Go to start  
-> Control panel  
-> System Security   
-> Under Action center, choose **Change User Account Control settings**  
-> Drag the bar all the way down to **Never notify**  
-> Ok  
-> Restart

## Enable firewall rules for RDP and WinRM
```Powershell
Set-NetFirewallRule -Name WINRM-HTTP-IN-TCP-PUBLIC -RemoteAddress Any
Set-NetFirewallRule -Name RemoteDesktop-UserMode-In-TCP -Enabled True
```

## Change Powershell execution policy
```Powershell
Set-ExecutionPolicy -ExecutionPolicy Unrestricted
```

## Install important updates
> Self explanatory

## Cleanup WinSXS update debris
```Powershell
Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase
```

## (Optional) Additional disk cleanup
```Powershell
C:\Windows\System32\cleanmgr.exe /d c:

@('InkAndHandwritingServices',
  'Server-Media-Foundation',
  'Powershell-ISE') | Remove-WindowsFeature

Get-WindowsFeature | 
? { $_.InstallState -eq 'Available' } | 
Uninstall-WindowsFeature -Remove

Optimize-Volume -DriveLetter C

wget http://download.sysinternals.com/files/SDelete.zip -OutFile sdelete.zip
[System.Reflection.Assembly]::LoadWithPartialName("System.IO.Compression.FileSystem")
[System.IO.Compression.ZipFile]::ExtractToDirectory("sdelete.zip", ".") 
./sdelete.exe -z c:
```

## Shut down
```Powershell
Stop-computer
```

# Packaging and running the box
> Refer to *WISA-guide-create-basebox* to packge and create the base box



