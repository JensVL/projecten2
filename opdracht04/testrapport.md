# Testrapport Opdracht 4: Microsoft Deployment Toolkit

## Test 1

Uitvoerder(s) test: Jens Van Liefferinge
Uitgevoerd op: 11/05/19
Github commit:  cdeb80

## Prerequisites
Successfully installed reload plugin.

## Domain-Controller
Commented everything except for **domain-controller.ps1** and **domain-controller-configure.ps1**. 
Ran ```vagrant up DC```.
No errors shown, everything successful.

## Provision-base
Uncommented **provision-base.ps1**, the **reload** right after **provision-base.ps1** and **ad-explorer.ps1**.
Ran ```vagrant destroy -f && vagrant up DC```.
No errors shown, everything successful.

## Certification
Uncommented **ca.ps1** and the **reload** right after **ca.ps1**.
Ran ```vagrant destroy -f && vagrant up DC```.
No errors shown, everything successful.

## IP address settings and routing
Uncommented **fix-ip-settings-after-ad.ps1**, **routing-and-remote-access.ps1** and the **reload** right after **routing-and-remote-access.ps1.ps1**.
Ran ```vagrant destroy -f && vagrant up DC```.
No errors shown, everything succesful.

## NAT router
Uncommented **routing-nat.ps1**.
Ran ```vagrant destroy -f && vagrant up DC```.
No errors shown, everything succesful.

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
