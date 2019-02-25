# Testplan: Reset guide - Cisco router/switch

*Authors: Nathan Cammerman, Matthias Van De Velde*

## Switch
### Reload config
Goal: reloading running config to startup config.

---
1. Configure Switch with these settings:

Switch> enable  
Switch# config terminal  
Switch (config) Hostname Switch1  
Switch1 (config) enable secret admin  
Switch1 (config) Banner motd #Warning#  
Switch1 (config) exit  

---
2. Saving running config to startup config:

Switch# copy running-config startup-config

---
3. Check your running config:

Switch1# show running-config

You should see this:

Building configuration...  
Current configuration : 1150 bytes  
!  
version 12.2  
no service timestamps log datetime msec  
no service timestamps debug datetime msec  
no service password-encryption  
!  
**hostname Switch1**  
!  
**enable secret 5 $1$mERr$vTbHul1N28cEp8lkLqr0f/**  
!  
!  
!  
!  
!  
spanning-tree mode pvst  
spanning-tree extend system-id  
!  
interface FastEthernet0/1  
!  
interface FastEthernet0/2  
!  
interface FastEthernet0/3  
!  
interface FastEthernet0/4  
!  
interface FastEthernet0/5  
!  
interface FastEthernet0/6  
!  
interface FastEthernet0/7  
!  
interface FastEthernet0/8  
!  
interface FastEthernet0/9  
!  
interface FastEthernet0/10  
!  
interface FastEthernet0/11  
!  
interface FastEthernet0/12  
!  
interface FastEthernet0/13  
!  
interface FastEthernet0/14  
!  
interface FastEthernet0/15  
!  
interface FastEthernet0/16  
!  
interface FastEthernet0/17  
!  
interface FastEthernet0/18  
!  
interface FastEthernet0/19  
!  
interface FastEthernet0/20  
!  
interface FastEthernet0/21  
!  
interface FastEthernet0/22  
!  
interface FastEthernet0/23  
!  
interface FastEthernet0/24  
!  
interface GigabitEthernet0/1  
!  
interface GigabitEthernet0/2  
!  
interface Vlan1  
 no ip address  
 shutdown  
!  
**banner motd ^CWarning^C**  
!  
!  
!  
line con 0  
!  
line vty 0 4  
 login  
line vty 5 15  
 login  
!  
!  
!  
!  
end  

---
4. Change some settings without saving

Switch1# config terminal  
Switch1(config) hostname Switch2  
Switch1(config) enable secret noadmin  
Switch1(config) banner motd #Alert#  

---
5. Check your running config:

Switch2# show running-config

It should look like this:

Building configuration...

Current configuration : 1148 bytes  
!  
version 12.2  
no service timestamps log datetime msec  
no service timestamps debug datetime msec  
no service password-encryption  
!  
**hostname Switch2**  
!  
**enable secret 5 $1$mERr$Ijrb./re9NV7iq07YxrxH0**  
!  
!  
!  
!  
!  
spanning-tree mode pvst  
spanning-tree extend system-id  
!  
interface FastEthernet0/1  
!  
interface FastEthernet0/2  
!  
interface FastEthernet0/3  
!  
interface FastEthernet0/4  
!  
interface FastEthernet0/5  
!  
interface FastEthernet0/6  
!  
interface FastEthernet0/7  
!  
interface FastEthernet0/8  
!  
interface FastEthernet0/9  
!  
interface FastEthernet0/10  
!  
interface FastEthernet0/11  
!  
interface FastEthernet0/12  
!  
interface FastEthernet0/13  
!  
interface FastEthernet0/14  
!  
interface FastEthernet0/15  
!  
interface FastEthernet0/16  
!  
interface FastEthernet0/17  
!  
interface FastEthernet0/18  
!  
interface FastEthernet0/19  
!  
interface FastEthernet0/20  
!  
interface FastEthernet0/21  
!  
interface FastEthernet0/22  
!  
interface FastEthernet0/23  
!  
interface FastEthernet0/24  
!  
interface GigabitEthernet0/1  
!  
interface GigabitEthernet0/2  
!  
interface Vlan1  
 no ip address  
 shutdown  
!  
**banner motd ^CAlert^C**  
!  
!  
!  
line con 0  
!  
line vty 0 4  
 login  
line vty 5 15  
 login  
!  
!  
!  
!  
end  

---
6. Reload Switch without saving changes:

Switch2# reload  
Switch2# no

7. Check configuration
---
The switch should change back to what was saved in the startup config.

Switch1> enable  
Switch1# show running-config  

You should see the same output as the first configuration at step 3.



### Factory reset
Goal: resetting the whole switch back to factory mode.

---
1. Configure Switch with these settings:

Switch> enable  
Switch# config terminal  
Switch (config) Hostname Switch1  
Switch1 (config) enable secret admin  
Switch1 (config) Banner motd #Warning#  
Switch1 (config) exit  

---
2. Saving running config to startup config:

Switch# copy running-config startup-config

---
3. Check your running config:

Switch1# show running-config

You should see this:

Building configuration...  

Current configuration : 1150 bytes  
!  
version 12.2  
no service timestamps log datetime msec  
no service timestamps debug datetime msec  
no service password-encryption   
!  
**hostname Switch1**  
!  
**enable secret 5 $1$mERr$vTbHul1N28cEp8lkLqr0f/**  
!  
!  
!  
!  
!  
spanning-tree mode pvst  
spanning-tree extend system-id  
!  
interface FastEthernet0/1  
!  
interface FastEthernet0/2  
!  
interface FastEthernet0/3  
!  
interface FastEthernet0/4  
!  
interface FastEthernet0/5  
!  
interface FastEthernet0/6  
!  
interface FastEthernet0/7  
!  
interface FastEthernet0/8  
!  
interface FastEthernet0/9  
!  
interface FastEthernet0/10  
!  
interface FastEthernet0/11  
!  
interface FastEthernet0/12  
!  
interface FastEthernet0/13  
!  
interface FastEthernet0/14  
!  
interface FastEthernet0/15  
!  
interface FastEthernet0/16  
!  
interface FastEthernet0/17  
!  
interface FastEthernet0/18  
!  
interface FastEthernet0/19  
!  
interface FastEthernet0/20  
!  
interface FastEthernet0/21  
!  
interface FastEthernet0/22  
!  
interface FastEthernet0/23  
!  
interface FastEthernet0/24  
!  
interface GigabitEthernet0/1  
!  
interface GigabitEthernet0/2  
!  
interface Vlan1  
 no ip address   
 shutdown  
!  
**banner motd ^CWarning^C**  
!  
!  
!  
line con 0  
!  
line vty 0 4  
 login  
line vty 5 15  
 login  
!  
!  
!  
!  
end

---
4. now reset the whole Switch.

Switch1# erase startup-config  
Switch1# reload  
(If there is a prompt asking you to save recent changes type: no)

---
5. Check factory configuration.

The switch should change back to factory settings.

Switch1> enable  
Switch1# show running-config  

output:

Building configuration...  

Current configuration : 1078 bytes  
!  
version 12.2  
no service timestamps log datetime msec  
no service timestamps debug datetime msec  
no service password-encryption  
!  
hostname Switch  
!  
!  
!  
!  
!  
spanning-tree mode pvst  
spanning-tree extend system-id  
!  
interface FastEthernet0/1  
!  
interface FastEthernet0/2  
!  
interface FastEthernet0/3  
!  
interface FastEthernet0/4  
!  
interface FastEthernet0/5  
!  
interface FastEthernet0/6  
!  
interface FastEthernet0/7  
!  
interface FastEthernet0/8  
!  
interface FastEthernet0/9  
!  
interface FastEthernet0/10  
!  
interface FastEthernet0/11  
!  
interface FastEthernet0/12  
!  
interface FastEthernet0/13  
!  
interface FastEthernet0/14  
!  
interface FastEthernet0/15  
!  
interface FastEthernet0/16  
!  
interface FastEthernet0/17  
!  
interface FastEthernet0/18  
!  
interface FastEthernet0/19  
!  
interface FastEthernet0/20  
!  
interface FastEthernet0/21  
!  
interface FastEthernet0/22  
!  
interface FastEthernet0/23  
!  
interface FastEthernet0/24  
!  
interface GigabitEthernet0/1  
!  
interface GigabitEthernet0/2  
!  
interface Vlan1  
 no ip address  
 shutdown  
!  
!  
!  
!  
line con 0  
!  
line vty 0 4  
 login  
line vty 5 15  
 login  
!  
!  
!  
!  
end  

---
6. Switch resetted  
Now your Switch should be totally resetted



### Manual reload config

Goal: reloading running config to startup config.

---
1. Configure Switch with these settings:

Switch> enable  
Switch# config terminal  
Switch (config) Hostname Switch1  
Switch1 (config) enable secret admin  
Switch1 (config) Banner motd #Warning#  
Switch1 (config) exit

---
2. Saving running config to startup config:

Switch# copy running-config startup-config

---
3. Check your running config:

Switch1# show running-config

You should see this:

Building configuration...  

Current configuration : 1150 bytes  
! 
version 12.2  
no service timestamps log datetime msec  
no service timestamps debug datetime msec  
no service password-encryption  
!  
**hostname Switch1**  
!  
**enable secret 5 $1$mERr$vTbHul1N28cEp8lkLqr0f/**  
!  
!  
!  
!  
!  
spanning-tree mode pvst  
spanning-tree extend system-id  
!  
interface FastEthernet0/1  
!  
interface FastEthernet0/2  
!  
interface FastEthernet0/3  
!  
interface FastEthernet0/4  
!  
interface FastEthernet0/5  
!  
interface FastEthernet0/6  
!  
interface FastEthernet0/7  
!  
interface FastEthernet0/8  
!  
interface FastEthernet0/9  
!  
interface FastEthernet0/10  
!  
interface FastEthernet0/11  
!  
interface FastEthernet0/12  
!  
interface FastEthernet0/13  
!  
interface FastEthernet0/14  
!  
interface FastEthernet0/15  
!  
interface FastEthernet0/16  
!  
interface FastEthernet0/17  
!  
interface FastEthernet0/18  
!  
interface FastEthernet0/19  
!  
interface FastEthernet0/20  
!  
interface FastEthernet0/21  
!  
interface FastEthernet0/22  
!  
interface FastEthernet0/23  
!  
interface FastEthernet0/24  
!  
interface GigabitEthernet0/1  
!  
interface GigabitEthernet0/2  
!  
interface Vlan1  
 no ip address  
 shutdown  
!  
**banner motd ^CWarning^C**  
!  
!  
!  
line con 0  
!  
line vty 0 4  
 login  
line vty 5 15  
 login  
!  
!  
!  
!  
end  

---
4. Change some settings without saving

Switch1# config terminal  
Switch1(config) hostname Switch2  
Switch1(config) enable secret noadmin  
Switch1(config) banner motd #Alert#  

---
5. Check your running config:

Switch2# show running-config  

It should look like this:

Building configuration...  

Current configuration : 1148 bytes  
!  
version 12.2  
no service timestamps log datetime msec  
no service timestamps debug datetime msec  
no service password-encryption  
!  
**hostname Switch2**  
!  
**enable secret 5 $1$mERr$Ijrb./re9NV7iq07YxrxH0**  
!  
!  
!  
!  
!  
spanning-tree mode pvst  
spanning-tree extend system-id  
!  
interface FastEthernet0/1  
!  
interface FastEthernet0/2  
!  
interface FastEthernet0/3  
!  
interface FastEthernet0/4  
!  
interface FastEthernet0/5   
!  
interface FastEthernet0/6  
!  
interface FastEthernet0/7  
!  
interface FastEthernet0/8  
!  
interface FastEthernet0/9  
!  
interface FastEthernet0/10  
!  
interface FastEthernet0/11  
!  
interface FastEthernet0/12  
!  
interface FastEthernet0/13  
!  
interface FastEthernet0/14  
!  
interface FastEthernet0/15  
!  
interface FastEthernet0/16  
!  
interface FastEthernet0/17  
!  
interface FastEthernet0/18  
!  
interface FastEthernet0/19  
!  
interface FastEthernet0/20  
!  
interface FastEthernet0/21  
!  
interface FastEthernet0/22  
! 
interface FastEthernet0/23  
!  
interface FastEthernet0/24  
!  
interface GigabitEthernet0/1  
!  
interface GigabitEthernet0/2  
!  
interface Vlan1  
 no ip address  
 shutdown  
!  
**banner motd ^CAlert^C**  
!  
!  
!  
line con 0  
!  
line vty 0 4  
 login  
line vty 5 15  
 login  
!  
!  
!  
!  
end  

---
6. manually reload switch
    1. Disconnect all Ethernet cables from the switch.
    2. Using a pin, press and hold the Reset button on the switch for 15 to 20 seconds.
    3. Once all the port Light-Emitting Diodes (LEDs) light up, release the Reset button.
    4. Connect your computer directly to the switch using a serial cable.
    5. Log in to the switch console. If you have configured a new username or password, enter the credentials instead.
    6. You will be prompted to configure new password for better protection of your network. Press Y for Yes or N for No on your keyboard.
    7. (optional) Enter the old password then press Enter on your keyboard.
    8. (Optional) Enter and confirm the new password accordingly then press Enter on your keyboard.
    9. Enter the Global Configuration mode of the switch by entering the following: Switch# configure terminal

You should now have successfully reset the switch manually.

### Manual factory reset

Goal: resetting the whole switch back to factory mode.

---
1. Configure Switch with these settings:

Switch> enable  
Switch# config terminal  
Switch (config) Hostname Switch1  
Switch1 (config) enable secret admin  
Switch1 (config) Banner motd #Warning#  
Switch1 (config) exit  

---
2. Saving running config to startup config:

Switch# copy running-config startup-config

---
3. Check your running config:

Switch1# show running-config

You should see this:

Building configuration...  

Current configuration : 1150 bytes  
!  
version 12.2  
no service timestamps log datetime msec  
no service timestamps debug datetime msec  
no service password-encryption  
!  
**hostname Switch1**  
!  
**enable secret 5 $1$mERr$vTbHul1N28cEp8lkLqr0f/**  
!  
!  
!  
!  
!  
spanning-tree mode pvst  
spanning-tree extend system-id  
!  
interface FastEthernet0/1  
!  
interface FastEthernet0/2  
!  
interface FastEthernet0/3  
!  
interface FastEthernet0/4  
!  
interface FastEthernet0/5  
!  
interface FastEthernet0/6  
!  
interface FastEthernet0/7  
!  
interface FastEthernet0/8  
!  
interface FastEthernet0/9  
!  
interface FastEthernet0/10  
!  
interface FastEthernet0/11  
!  
interface FastEthernet0/12  
!  
interface FastEthernet0/13  
!  
interface FastEthernet0/14  
!  
interface FastEthernet0/15  
!  
interface FastEthernet0/16  
!  
interface FastEthernet0/17  
!  
interface FastEthernet0/18  
!  
interface FastEthernet0/19  
!  
interface FastEthernet0/20  
!  
interface FastEthernet0/21  
!  
interface FastEthernet0/22  
!  
interface FastEthernet0/23  
!  
interface FastEthernet0/24  
!  
interface GigabitEthernet0/1  
!  
interface GigabitEthernet0/2  
!  
interface Vlan1  
 no ip address  
 shutdown  
!  
**banner motd ^CWarning^C**  
!  
!  
!  
line con 0  
!  
line vty 0 4  
 login  
line vty 5 15  
 login   
!  
!  
!  
!  
end  

---
4. power the switch off.

---
5. Connect up your console cable and power on the switch, whilst holding down the “mode” button:
 
 after a short while (continue holding the “mode” button) you will see the following prompt:

Using driver version 1 for media type 1  
Base ethernet MAC Address: 4c:30:2d:81:ef:80  
Xmodem file system is available.  
The password-recovery mechanism is enabled.  
The system has been interrupted prior to initializing the  
flash filesystem. The following commands will initialize  
the flash filesystem, and finish loading the operating  
system software:  
flash_init  
 boot  
switch:  

---
6. Initialize the flash file system with the command: flash_init
 
switch: flash_init  
Initializing Flash...  
mifs[2]: 10 files, 1 directories  
mifs[2]: Total bytes : 1806336  
mifs[2]: Bytes used : 612352  
mifs[2]: Bytes available : 1193984  
mifs[2]: mifs fsck took 1 seconds.  
mifs[3]: 0 files, 1 directories  
mifs[3]: Total bytes : 3870720  
mifs[3]: Bytes used : 1024  
mifs[3]: Bytes available : 3869696  
mifs[3]: mifs fsck took 0 seconds.  
mifs[4]: 5 files, 1 directories  
mifs[4]: Total bytes : 258048  
mifs[4]: Bytes used : 9216  
mifs[4]: Bytes available : 248832  
mifs[4]: mifs fsck took 0 seconds.  
mifs[5]: 5 files, 1 directories  
mifs[5]: Total bytes : 258048  
mifs[5]: Bytes used : 9216  
mifs[5]: Bytes available : 248832  
mifs[5]: mifs fsck took 1 seconds.  
 -- MORE --  
mifs[6]: 566 files, 19 directories  
mifs[6]: Total bytes : 57931776  
mifs[6]: Bytes used : 28429312  
mifs[6]: Bytes available : 29502464  
mifs[6]: mifs fsck took 21 seconds. 
...done Initializing Flash.  

---
7. Delete the config.text file from the flash directory:

switch: del flash:config.text  
Are you sure you want to delete "flash:config.text" (y/n)?y  
File "flash:config.text" deleted  

---
8. Delete the vlan.dat file from the flash directory:

switch: del flash:vlan.dat  
Are you sure you want to delete "vlan.dat" (y/n)?y  
File "flash:vlan.dat" deleted  

---
9. Reboot the switch and you’re done:  

switch: boot  
Loading "flash:c2960s-universalk9-mz.122-58.SE2.bin"...  
--- System Configuration Dialog ---  
Enable secret warning  

----------------------------------
In order to access the device manager, an enable secret is required
If you enter the initial configuration dialog, you will be prompted for the enable secret
If you choose not to enter the intial configuration dialog, or if you exit setup without setting the enable secret,
please set an enable secret using the following CLI in configuration mode-
enable secret 0 <cleartext password>

----------------------------------

Would you like to enter the initial configuration dialog? [yes/no]:
% Please answer 'yes' or 'no'.

---
## Router

### Reload config(reset running config naar startup config)
1. Configure the router with these settings
```Markdown
Router# enable
Router# configure terminal
Router(config)# hostname R1
R1(config)# enable secret admin
R1(config)# interface GigabitEthernet0/0
R1(config-if)# ip address 192.168.16.1 255.255.255.0
R1(config-if)# end
```
2. Save the settings
```Markdown
R1# copy running-config startup-config
```
3. Change the settings
```
R1# configure terminal
R1(config)# hostname R2
R2(config)# enable secret password
R2(config)# interface GigabitEthernet0/0
R2(config-if)# ip address 123.123.123.0 255.255.255.0
R2(config-if)# end
```
4. Reload the configuration, enter N only if you're prompted to choose and press enter to confirm.
```Markdown
R2(config)# reload
System configuration has been modified. Save? [yes/no]: n
Proceed with reload? [confirm]
```
5. You should now be able to log in using 'admin' (without quotes). The prompt should look like this: `R1#`. 
6. Type `show ip interface brief` and you should see this:  

|||||||
|-|-|-|-|-|-|
| GigabitEthernet0/0 | 192.168.16.1 | YES | manual | up | up |
|||||||




### Factory reset
1. Configure the router with these settings
```Markdown
Router# enable
Router# configure terminal
Router(config)# hostname R1
R1(config)# enable secret admin
R1(config)# interface GigabitEthernet0/0
R1(config-if)# ip address 192.168.16.1 255.255.255.0
R1(config-if)# end
```
2. Save the settings
```Markdown
R1# copy running-config startup-config
```
3. Erase startup config
```Markdown
R1# write erase
Erasing the nvram filesystem will remove all configuration files! Continue? [confirm]
```
4. Reload
```Markdown
R1# reload
Proceed with reload? [confirm]
```
5. You should now be prompted with the default prompt.
```Markdown
Router> 
```
6. Check the interfaces, you should see the following output:
```Markdown
Router# show ip interface brief
```
| Interface | IP-Address | OK? | Method | Status | Protocol |
|---|---|---|---|---|---|
| GigabitEthernet0/0 | unassigned | YES | unset | administratively down | down |
| GigabitEthernet0/1 | unassigned  | YES | unset |administratively down | down |
| Vlan1 | unassigned | YES | unset | administratively down | down |


### Manual reload config
No records found

### Manual factory reset
1. Configure the router with these settings
```Markdown
Router# enable
Router# configure terminal
Router(config)# hostname R1
R1(config)# enable secret admin
R1(config)# interface GigabitEthernet0/0
R1(config-if)# ip address 192.168.16.1 255.255.255.0
R1(config-if)# end
```
2. Save the settings
```Markdown
R1# copy running-config startup-config
```
3. Turn off the router.
4. Disconnect the powercord and wait 10-15 seconds.
5. Reconnect the powercord.
6. Hold the reset button for 10 seconds while starting the router.
7. Wait 5 - 10 minutes for the router to fully boot.
8. Shut down the router
9. Next time you boot up the router, the factory settings are restored.
10. You should now be prompted with the default prompt.
```Markdown
Router> 
```
11. Check the interfaces, you should see the following output:
```Markdown
Router# show ip interface brief
```
| Interface | IP-Address | OK? | Method | Status | Protocol |
|---|---|---|---|---|---|
| GigabitEthernet0/0 | unassigned | YES | unset | administratively down | down |
| GigabitEthernet0/1 | unassigned  | YES | unset |administratively down | down |
| Vlan1 | unassigned | YES | unset | administratively down | down |