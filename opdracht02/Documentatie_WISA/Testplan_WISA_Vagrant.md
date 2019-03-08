# Testplan: Base box Vagrant (WISA)
*Author: Nathan Cammerman*

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
3. Login using 'vagrant' without quotes.


## Test WinRm turned on

1. Open a powershell terminal and type

```
Test-WSMan
```

3. If WinRm is running you will see the following items: 
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

# Connect to the databases

1. Open Microsoft SQL Server Management Studio with the following parameters:

```
Server name: 192.168.248.10,50000
Authentication: SQL Server Authentication
Login: vagrant
Password: vagrant
```

# Deploying webapplicationserver
## Requirements
* Visual Studio 2017
* Windows 2016 box up and provisioned

1. Download the web application from the following server.
https://github.com/WebIII/08thBeerhallMvcCRUD/archive/master.zip

2. Extract the folder to any location.

3. Open the project with PROJECT_NAME.sln file (Allocated in the DOTNET project-map)

4. Right click on the application in the solution explorer and select the “Publish” option

5. Create new publishing profile: “IIS, FTP, etc”

5. Enter following settings:

```
Publish method: Web Deploy
Server: 192.168.248.10
Site name: Default Web Site
User name: vagrant
Password: vagrant
Destination URL: http://192.168.248.10/Bierhall
Validate connection and press “next”
```
6. Choose configuration option "Debug" and tik boxes "Remove additional files at destination" and "Exclude files from the App_Data folder" on. 

7. Press Save and Publish the Application.


## Test webapplicationserver

1. To test, you can surf on your host-machine to 192.168.248.10 and the application should be running

2. To verify the Database functionality: try to add, edit and delete information and reload the page after each operation.