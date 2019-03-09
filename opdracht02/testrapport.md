# Testrapport: Base Box Vagrant (WISA)

## Test 1

Uitvoerder(s) test: Jens Van Liefferinge
Uitgevoerd op: 09/03/2019
Github commit:  8182ed3

## Test Virtual Machine

### Boot VM

Virtual machine successfully started using the command.

### Test remote desktop enabled

Successfully logged in using 'vagrant' as password. Remote desktop started and functioning.

## Test WinRm turned on

Successfully opened a powershell process and executed the given command. Output below:

```
wsmid           : http://schemas.dtf.org/wbem/wsman/identity/1/wsmanidentity.xsd
ProtocolVersion : http://schemas.dmtf.org/wbem/wsman/1/wsman.xsd
ProductVendor   : Microsoft Corporation
ProductVersion  : OS: 0.0.0 SP: 0.0 Stack: 3.0
```

The received output is the same as the required output from the test.

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

Successfully created new publishing profile. Upon ticking the correct boxes, option "Exclude files from the App_Data folder" is not present. When completing the profile and hitting publish, the following error shows:

Error: Web deployment task failed. (Unable to perform the operation ("Delete Directory") for the specified directory ("2_0_50727"). This can occur if the server administrator has not authorized this operation for the user credentials you are using. Learn more at: http://go.microsoft.com/fwlink/?LinkId=221672#ERROR_INSUFFICIENT_ACCESS_TO_SITE_FOLDER.)

## Test webapplicationserver

Surfing to 192.168.248.10 gives a blank page, with the title "Site Under Construction". This probably has to do with the previous error, as there is no site published.
