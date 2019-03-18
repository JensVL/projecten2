# Vagrant Base box creation
*Author: Nathan Cammerman, Matthias Van De Velde    *

## Install required software
### Virtualbox
Click on the link and download the appropriate version:  
https://www.virtualbox.org/wiki/Downloads

### Vagrant
Click on the link and download the appropriate version:  
https://www.vagrantup.com/downloads.html

---

## Create a Virtual Machine
1. Open Virtualbox and create a new VM
2. Give it a name and select Windows 2016 (64-bit) as the version
3. Go with the default options
4. In the settngs of the VM, go to storage and attach the Windows 2016 ISO to the virtual optical drive
(Optional)
5. You can always increase RAM and CPU if it's too slow


## Create base box

1. Open command prompt on host PC
2. Navigate to the location where you want to store the base box
3. Type in the command: 
```
vagrant package --base <name_of_VM> --output <name_of_VM.box>
```
4. When the process is finished you should see a .box-file with the same name as the VM


## Add base box 

1. To add the base box to your list of base boxes, use the command 
```
vagrant box add --name <name_of_VM> <path/to/name_of_VM.box>
```


## Initializing box

* If you want to start a new project, create a new folder and execute the following command in the same directory:
```
vagrant init <name_of_VM>
``` 
* If you want to use the base box in an existing project, edit Vagrantfile like so   
```
config.vm.box = "<name_of_VM>"
```  
* Or in our case, add a new host to vagrant-hosts.yml and specify the box like so:  
```
box: <name_of_VM>
```


## Start up box

1. In the same directory where you used `vagrant init` or where there is already and existing Vagrantfile, use the command `vagrant up`
2. If you are left with a blank prompt and no error messages during the boot, everything went well 


## Remote desktop connection

1. In the same directory as the box you just booted, use the command `vagrant rdp` and log in using 'vagrant' (without quotes)
2. If you don't see a popup to make a remote desktop connection, add the ports 3389 as forwarded ports in vagrant-hosts.yml or straight in Vagrantfile 