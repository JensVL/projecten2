# Testplan Opdracht 4: Microsoft Deployment Toolkit

Auteur(s) testplan: Matthias Van De Velde

## Prerequisites
```Bash
vagrant plugin install vagrant-reload
```

## Domain-Controller
In the provisioning part in Vagrantfile, comment out every shell provisioner and reload except **domain-controller.ps1** and **domain-controller-configure.ps1**. 
Run ```vagrant up DC```. If you see no errors, everything was successful.

## Provision-base
Uncomment **provision-base.ps1**, the **reload** right after **provision-base.ps1** and **ad-explorer.ps1**.
Run ```vagrant destroy -f && vagrant up DC```. If you see no errors, everything was successful.

## Certification
Uncomment **ca.ps1** and the **reload** right after **ca.ps1**.
Run ```vagrant destroy -f && vagrant up DC```. If you see no errors, everything was successful.

## IP address settings and routing
Uncomment **fix-ip-settings-after-ad.ps1**, **routing-and-remote-access.ps1** and the **reload** right after **routing-and-remote-access.ps1.ps1**.
Run ```vagrant destroy -f && vagrant up DC```. If you see no errors, everything was successful.

## NAT router
Uncomment **routing-nat.ps1**.
Run ```vagrant destroy -f && vagrant up DC```. If you see no errors, everything was successful.

## DNS
Uncomment **dns.ps1**.
Run ```vagrant destroy -f && vagrant up DC```. If you see no errors, everything was successful.

## DHCP
Uncomment **dhcp.ps1** and the **reload** right after **dhcp.ps1**.
Run ```vagrant destroy -f && vagrant up DC```. If you see no errors, everything was successful.

## MDT installation
Uncomment **mdt-install.ps1** and the **reload** right after **mdt-install**. Run ```vagrant destroy -f && vagrant up DC```. If you see no errors, everything was successful.


## MDT upgrade
Uncomment **mdt-upgrade.ps1** and the **reload** right after **mdt-upgrade.ps1**. Run ```vagrant destroy -f && vagrant up DC```. If you see no errors, everything was successful.

## MDT configuration
Uncomment **mdt-config.ps1** and the **reload** right after **mdt-config.ps1**. Run ```vagrant destroy -f && vagrant up DC```. If you see no errors, everything was successful.

## WDS
Uncomment **wds.ps1** and the reload right after **wds.ps1**. Run ```vagrant destroy -f && vagrant up DC```. If you see no errors, everything was successful.

## Client
Run ```vagrant destroy -f && vagrant up```. If you see no errors, everything was successful. 
