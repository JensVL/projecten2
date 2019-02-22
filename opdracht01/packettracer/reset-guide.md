# Reset guide: Cisco router/switch

## Switch
### Reload config
### Factory reset
### Manual reload config
### Manual factory reset

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
| Serial0/0/0 | unassigned | YES | unset | administratively down | down |
| Serial0/0/1 | unassigned | YES | unset | administratively down | down |
| Vlan1 | unassigned | YES | unset | administratively down | down |


### Manual reload config

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
| Serial0/0/0 | unassigned | YES | unset | administratively down | down |
| Serial0/0/1 | unassigned | YES | unset | administratively down | down |
| Vlan1 | unassigned | YES | unset | administratively down | down |