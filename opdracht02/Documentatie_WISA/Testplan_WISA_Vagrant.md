# Testplan: Base box Vagrant (WISA)
*Author: Nathan Cammerman*

## Test Virtual Machine 

### Test Login

1. Start your virtual machine.

2. Use password "vagrant" to log into the virtual machine.


## Test WinRm turned on

1. Open the powershell in your virtual machine.

2. type in the command `Test-WSMan`.

3. If WinRm is running you will see the following items: the WS-Management identity schema, the protocol version, the product vendor, and the product version of the tested service.

### Test UAC turned off 

1. Open the powershell in your virtual machine.

2. type in the command `REG QUERY HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\ /v EnableLUA`.

3. If the results read `NABLELUA REG_DWORD 0x1`, then UAC is enabled. If the output shows `ENABLELUA REG_DWORD 0x0`, then UAC is successfully disabled.

4. If UAC is enabled, please refer to "User guide" Step 21.

### Test shared folder enabled

1. Open the powershell in your virtual machine.

2. type in the command `Get-WmiObject -Class Win32_Share`.
The Win32_Share WMI class returns all instances of shared folders on a computer.

3. If it is disabled please refer to "User guide" step XX.

### Test internet connectivity

1. Open a browser in your virtual machine.

2. Surf to a desired site.

3. You should be able to access this site if you have an internet connection.

### Test ping connection guest to host

1. Turn off the firewall of your host machine.

2. Ping from your virtual machine to your host machine.

3. You should see successful pings.

4. After you are done, please turn your firewall back on of your host machine.

### Test remote desktop enabled

1. Open server manager on virtual machine.

2. In the server manager dashboard you should see under remote desktop enabled.

3. If it is disabled please follow step 27 of our "User guide".

## Vagrant Base box

### Initializing box

1. Open command prompt on host PC.

2. Navigate to desired location in the directory.

3. In the command prompt use the command `vagrant init *name basebox*`

4. Don't close the command prompt you need it to persue the following steps.

---

### Startup box

1. In the same command prompt use the command `vagrant up`. You don't need to specialize a basebox because you already have initialized it.

2. If everything went correct the base box should start up.

3. Don't close the command prompt you need it to persue the following steps.

---

### Remote desktop connection

1. In the same command prompt use the command `vagrant rdp` to log into the base box.

2. Use password "vagrant" (without quotes) to gain access to the basebox.

3. Now you should be able to use the basebox.

# Connect to the databases

1. Open Microsoft SQL Server Management Studio met volgende parameters:

```
Server name: 192.168.248.10,50000
Authentication: SQL Server Authentication
Login: vagrant
Password: vagrant
```

# Deploying webapplicationserver

1. Open het project met de PROJECT_NAAM.sln file (Gealloceerd in de DOTNETproject-map)

2. Right click on the application in the solution explorer and select the “Publish” option

3. Create new publishing profile: “IIS, FTP, etc”

4. Enter following settings:

```
Publish method: Web Deploy
Server: 192.168.248.10
Site name: Default Web Site
User name: vagrant
Password: vagrant
Destination URL: http://192.168.248.10/Bierhalle
Validate connection and press “next”
```
5. Chose configuration option "Debug" and tik boxes "Remove additional files at destination" and "Exclude files from the App_Data folder" on. 

6. Press Save and Publish the Application.

## Test webapplicationserver

7. To test, you can surf on your host-machine to 192.168.248.10 and the application should be running

8. To verify the Database functionality: try to add, edit and delete information and reload the page after each operation.