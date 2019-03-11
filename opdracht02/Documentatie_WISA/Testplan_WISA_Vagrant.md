# Testplan: Base box Vagrant (WISA)
*Author: Nathan Cammerman, Matthias Van De Velde*

## Test Virtual Machine 
### Boot VM
1. Start your virtual machine.
```
vagrant up
```

### Test remote desktop enabled
1. Make a Remote Desktop Connection
```
vagrant rdp
```
2. Login using 'vagrant' without quotes.


### Test WinRm turned on
1. Open a powershell terminal and type
```
Test-WSMan
```
2. If WinRm is running you will see the following items: 
```
wsmid           : http://schemas.dmtf.org/wbem/wsman/identity/1/wsmanidentity.xsd
ProtocolVersion : http://schemas.dmtf.org/wbem/wsman/1/wsman.xsd
ProductVendor   : Microsoft Corporation
ProductVersion  : OS: 0.0.0 SP: 0.0 Stack: 3.0
```

### Test UAC turned off 
1. Open the powershell in your virtual machine.
2. Type in the command 
```
REG QUERY HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\ /v EnableLUA
```
3. If the results read `NABLELUA REG_DWORD 0x1`, then UAC is enabled. If the output shows `ENABLELUA REG_DWORD 0x0`, then UAC is successfully disabled.


### Test shared folder enabled
1. Open the powershell in your virtual machine.
2. Go to the root directory of the C drive.
```
cd /
```
3. Check for the folder *vagrant* and try to access it.
```
dir vagrant
cd vagrant
```


### Test internet connectivity
1. Open a browser in your virtual machine.
2. Surf to a desired site.
3. You should be able to access this site if you have an internet connection.


### Test ping connection guest to host
1. Turn off the firewall of your host machine.
2. Ping from your virtual machine to your host machine.
3. You should see successful pings.
4. After you are done, please turn your firewall back on of your host machine.


## Vagrant Base box
### Connect to the databases
1. Open Microsoft SQL Server Management Studio with the following parameters:
```
Server name: 192.168.248.10,50000
Authentication: SQL Server Authentication
Login: vagrant
Password: vagrant
```


## Deploying webapplicationserver
### Requirements
* Visual Studio 2017
* Windows 2016 box up and provisioned

1. Download the following web application.  
https://code.msdn.microsoft.com/ASPNET-Web-Deployment-c2d409f9/file/116730/2/ASP.NET%20Web%20Deployment%20using%20Visual%20Studio.zip
2. Extract the folder to any location.
3. Open the .sln-file in `ContosoUniversity-End/`
4. Right click on the application(not the solution itself) in the solution explorer and select the “Publish” option
5. Create new publishing profile: “IIS, FTP, etc”
6. Enter following settings:
```
Publish method: Web Deploy
Server: 192.168.248.10
Site name: Default Web Site/ContosoUniversity
User name: vagrant
Password: vagrant
Destination URL: http://192.168.248.10/ContosoUniversity
Validate connection and press “next”
```
7. Choose configuration option "Debug" and tik boxes "Remove additional files at destination" and "Exclude files from the App_Data folder" on. 
8. Under Databases, configure both connection strings by clicking on the triple dot button. Both have the same configuration
![database-connectionstring-config](database-connectionstring-config.png)

8. Press Save.
9. Go to the properties of the the application.
10. Under Application, set the target framework to .NET Framework 4.6
11. Go to Package/Publish SQL and click on import from Web.config 
12. Configure both connection strings by clicking on the triple dot button. Both have the same configuration
![database-connectionstring-config](database-connectionstring-config.png)
12. Press Ctrl + Shift + S to save everything
13. Go back to the publish page by right clicking on the application and selecting publish.
14. Chcekc if the customProfile is selected and press publish


### Test webapplicationserver
1. To test, you can surf on your host-machine to 192.168.248.10 and the application should be running
2. To verify the Database functionality: try to add, edit and delete information and reload the page after each operation.