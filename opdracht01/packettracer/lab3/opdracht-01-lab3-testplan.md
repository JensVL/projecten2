# Testplan: Opdracht 1 - Labo 3
*Author: Yordi De Rijcke*

## Basic PC configuration
### PC-A
1. Click on PC-A.
2. Go to Destop > Command Prompt.
3. Type `ipconfig`.
4. The following output is expected:  
FastEthernet0 Connection:(default port)

   Link-local IPv6 Address.........: FE80::2D0:97FF:FE30:C67
   IP Address......................: 192.168.1.3
   Subnet Mask.....................: 255.255.255.0
   Default Gateway.................: 192.168.1.1

### PC-B
1. Click on PC-B.
2. Go to Destop > Command Prompt.
3. Type `ipconfig`.
4. The following output is expected:  
FastEthernet0 Connection:(default port)

   Link-local IPv6 Address.........: FE80::20C:85FF:FEA3:9317
   IP Address......................: 192.168.0.3
   Subnet Mask.....................: 255.255.255.0
   Default Gateway.................: 192.168.0.1
   
## Basic router configuration
### R1
1. Press enter and use 'cisco' (without quotes) as password to access user exec mode.
2. Type `enable` and use 'class' (without quotes) as password to access priviliged exec mode.
3. Type `show running-config`.
4. The following output is expected:
Building configuration...

Current configuration : 972 bytes
!
version 15.1
no service timestamps log datetime msec
no service timestamps debug datetime msec
service password-encryption
!
hostname R1
!
!
!
enable secret 5 $1$mERr$9cTjUIEqNGurQiFU.ZeCi1
!
!
!
!
!
!
no ip cef
no ipv6 cef
!
!
!
!
license udi pid CISCO1941/K9 sn FTX15240EJV
!
!
!
!
!
!
!
!
!
no ip domain-lookup
!
!
spanning-tree mode pvst
!
!
!
!
!
!
interface GigabitEthernet0/0
 description This is the interface connected to PC-B
 ip address 192.168.0.1 255.255.255.0
 duplex auto
 speed auto
!
interface GigabitEthernet0/1
 description This is the interface connected to the switch.
 ip address 192.168.1.1 255.255.255.0
 duplex auto
 speed auto
!
interface Vlan1
 no ip address
 shutdown
!
ip classless
!
ip flow-export version 9
!
!
!
banner motd ^CUnauthorized access is strictly prohibited and prosecuted to the full extend of the law. ^C
!
!
!
!
line con 0
 password 7 0822455D0A16
 login
!
line aux 0
!
line vty 0 4
 password 7 0822455D0A16
 login
!
!
!
end
