# Reset guide - Cisco router/switch

## Reset Router Using Reset Button

To reset your router to its factory-default configuration using the Reset button:

1.	With the router powered off, connect the power cord to your router, and plug the power cord into your power source.
2.	Find the Reset button on the router.
3.	Press and hold the Reset button while you power on the router.
4.	Release the Reset button after 10 seconds.
5.	Wait 5 to 10 minutes for the router to finish booting. You can check the lights on the router — when the lights are solid or blink in repeating patterns, the router is finished booting.
6.	Power off your router.
At this point, your router is reset and will boot into its factory-default configuration the next time you power it on.



## Reset Router Using Router Commands
To reset your router to its factory-default configuration using router commands:
1.	With your router powered off, connect the power cord to the router, and plug the power cord into your power source.
2.	Connect your laptop to the console port on your router with the console cable.
3.	Power on the router and wait 5 to 10 minutes for the router to finish booting. You can check the lights on the router — when the lights are solid or blink in repeating patterns, the router is finished booting.
4.	On your laptop, start the terminal emulator program and use it to access your router’s command line interface (CLI).
5.	In the router CLI, enter the commands in boldface to erase the existing configuration on your router and reload the factory-default configuration on the router: 

router> enable  
router# write erase  
Erasing the nvram filesystem will remove all configuration files! Continue? [confirm] <Press Enter key>    
router# reload  
Proceed with reload? [confirm] <Press Enter key>  
-OR-  
Would you like to enter the initial configuration dialog? [yes|no] no <Press Enter key>  
–OR–  
Do you want to save the configuration of the AP? [yes|no] no <Press Enter key>  

6.	Wait until the reload or erase finishes and a CLI prompt or completion message appears.
7.	Close the terminal emulator window on your laptop.
8.	Power off the router.
At this point, your router is reset and will boot into its factory-default configuration the next time you power it on.

 


## Manually reset the Switch to factory defaults through the CLI

Note: The available commands may vary depending on the exact model of your device. In this example, SG350X-48MP switch is used.

1)	Log in to the switch console. 
2)	(if you want to keep the startup-config, skip this step) Use the command “erase startup-config”, then press enter.
3)  To reload/reset the switch, enter either of the following commands:
- reload — Use the reload command to reload the switch immediately.
- reload {{in hhh:mm | mmm | at hh:mm [day month]}} — Use this command to specify scheduled switch reload.
- in hhh:mm | mmm — Schedules a reload of the image to take effect in the specified minutes or hours and minutes. The reload must take place within approximately 24 days.
- at hh:mm — Schedules a reload of the image to take place at the specified time by using a 24-hour format. If you specify the month and day, the reload is scheduled to take place at the specified time and date. If you do not specify the month and day, the reload takes place at the specified time on the current day (if the specified time is later than the current time) or on the next day (if the specified time is earlier than the current time). Specifying 00:00 schedules the reload for midnight. The reload must take place within 24 hours.

4) Press Y for Yes on your keyboard. This command will reset the whole system and disconnect your current session prompt appears.
5) (Optional) To display information about a scheduled reload, enter the following:
Switch# show reload
6) (Optional) To cancel the scheduled reload, enter the reloadcancel command.
Switch# reload cancel

You should now have successfully reloaded your switch through the CLI.




## Manually Reload the Switch
When the switch fails to work and cannot be reset by using the web-based utility, the switch can be manually reset to restore the factory default configuration.
Step 1. Disconnect all Ethernet cables from the switch.

Step 2. Using a pin, press and hold the Reset button on the switch for 15 to 20 seconds.
 
Step 3. Once all the port Light-Emitting Diodes (LEDs) light up, release the Reset button.
Note: Telnet and SSH services are disabled by default. You will have to access the console of the switch using the computer that is directly connected to your switch through the serial cable.

Step 4. Connect your computer directly to the switch using a serial cable.

Step 5. Log in to the switch console. If you have configured a new username or password, enter the credentials instead.

Step 6. You will be prompted to configure new password for better protection of your network. Press Y for Yes or N for No on your keyboard.
Note: In this example, Y is pressed. If N is pressed, skip to Step 9.

Step 7. (Optional) Enter the old password then press Enter on your keyboard.

Step 8. (Optional) Enter and confirm the new password accordingly then press Enter on your keyboard.

Step 9. Enter the Global Configuration mode of the switch by entering the following:
Switch# configure terminal

Step 10. (Optional) To enable the SSH service on your switch, enter the following command:
Switch#  ip ssh server

You should now have successfully reset the switch manually.



## Reset a Cisco 2960 Switch To Factory Default Settings

Step 1. Connect up your console cable and power on the switch, whilst holding down the “mode” button:
 
 
This interrupts the boot process before the Flash file system can initialize, and after a short while (continue holding the “mode” button) you will see the following prompt:

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

Step 2. Initialize the flash file system with the command: flash_init
 
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

Step 3. Delete the config.text file from the flash directory:

switch: del flash:config.text  
Are you sure you want to delete "flash:config.text" (y/n)?y  
File "flash:config.text" deleted  

Step 4. Delete the vlan.dat file from the flash directory:

switch: del flash:vlan.dat  
Are you sure you want to delete "vlan.dat" (y/n)?y  
File "flash:vlan.dat" deleted 

Step 5. Reboot the switch and you’re done:

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

