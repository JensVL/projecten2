# Testrapport: Base Box Vagrant (WISA)

## Test 2

Uitvoerder(s) test: Jens Van Liefferinge
Uitgevoerd op: 12/03/2019
Github commit:  c1d322c

## Test Virtual Machine

### Boot VM

Virtual machine successfully started using the command "vagrant up".

### Test remote desktop enabled

Successfully logged in using "vagrant" as password. Remote desktop started and functioning.

## Test WinRm turned on

Successfully opened a powershell process and executed the given command. Output below:

```
wsmid           : http://schemas.dtf.org/wbem/wsman/identity/1/wsmanidentity.xsd
ProtocolVersion : http://schemas.dmtf.org/wbem/wsman/1/wsman.xsd
ProductVendor   : Microsoft Corporation
ProductVersion  : OS: 0.0.0 SP: 0.0 Stack: 3.0
```

The received output is the same as the expected output from the test.

## Test UAC turned off

 Successfully ran the command in a powershell window. Output below:
 ```
 EnableLUA      REG_DWORD      0x0
 ```
 UAC is successfully turned off.


## Test shared folder enabled

Successfully opened powershell and changed directory. Folder vagrant exists, successfully accessed C:\vagrant

### Test internet connectivity

Successfully accessed www.google.com and https://en.wikipedia.org.

### Test ping connection gues to host

Successfully pinged host machine from the virtual machine. Packets sent = 4; packets received = 4.

## Vagrant Base box

# Connect to the databases

Successfully connected to the databases using the provided settings.

# Deploying webapplicationserver

Successfully created a new publishing profile with the received settings. Connection validated and successful. Configured both connection strings with the given settings. Successfully set the application target framework to .NET Framework 4.6. Imported successfully from Web.config. Configured both connection strings with the given settings. Successfully published and ended up on http://192.168.248.10/ContosoUniversity/, showing a welcome page.

## Test webapplicationserver

Surfing to 192.168.248.10 gives a IIS landing page.

Successfully added a student on http://192.168.248.10/ContosoUniversity/Students.aspx, which showed up in the database. After deleting the student on the website, the student was also deleted in the database.
