# Technical Documentation
authors: Olivier De Vriese & Yordi De Rijcke

## What happens during the provisioning

### Using Windows 2016 base box with 100GB of space
Run ```vagrant up DC```
1. Installing the following roles and features
    - ADDS and promoting to domain controller
    - DHCP (and enabling option 066 and 067)
	    * 066: IP of the server (interface where DHCP will run)
	    * 067: boot\x64\wdsnbp.com
    - Remote Access (NAT routing)
    - DNS
    - Windows Deployment Services
2. Creating a DHCP scope using range 192.168.248.50 until 192.168.248.50
3. Setting up NAT
4. Configure and Enable Routing and Remote Access with 'NAT'
5. Installing and configuring MDT and ADK
    - Deployment share has Libre Office, JAVA 12 and Adobe Reader DC
    - Windows 10 iso is donloaded automatically
6. Installing and configuring WDS
    
### Connecting a client
Run ```vagrant up Client```
1. Adds network booting (PXE) to the boot options of the VM
2. Follow the intuitive installation procedure


## Possible errors during provisioning

If there is an error during the provisioning and it's related to the dhcp.ps1, commment the following line in Vagrantfile:

**config.vm.provision "shell", path: "provision/ps.ps1", args: "dhcp.ps1"**

Let the rest of the provisioning run.

Provided there are no more errors, you can now run ```vagrant up Client``` to connect the client to the PXE boot server


![](provisioning_screenshots/domain-controller-1.png)
![](provisioning_screenshots/domain-controller-2.png)
![](provisioning_screenshots/domain-controller-configure-1.png)
![](provisioning_screenshots/installing-chocolatey.png)
![](provisioning_screenshots/base-provisioning.png)
![](provisioning_screenshots/fix-ip-settings-and-install-nat-routing.png)
![](provisioning_screenshots/nat-routing-and-dhcp.png)
![](provisioning_screenshots/installing-mdt.png)
![](provisioning_screenshots/mdt-upgrade.png)
![](provisioning_screenshots/mdt-config-1.png)
![](provisioning_screenshots/mdt-config-2.png)
![](provisioning_screenshots/mdt-config-3.png)
![](provisioning_screenshots/mdt-config-4.png)
![](provisioning_screenshots/mdt-config-5.png)
![](provisioning_screenshots/mdt-config-6.png)
![](provisioning_screenshots/mdt-config-7.png)
![](provisioning_screenshots/mdt-config-8.png)
![](provisioning_screenshots/mdt-config-9.png)
![](provisioning_screenshots/mdt-config-10.png)
![](provisioning_screenshots/mdt-config-11.png)
![](provisioning_screenshots/mdt-config-12.png)
![](provisioning_screenshots/wds.png)