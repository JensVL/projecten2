# Testplan: Opdracht 1 - Labo 3
*Author: Yordi De Rijcke*

## Basic PC configuration
### PC-A
1. Type `ipconfig` in CMD:
2. The expected IPv4 results are:
IP Address......................: 192.168.1.3
Subnet Mask.....................: 255.255.255.0
Default Gateway.................: 192.168.1.1

### PC-B
1. Type `ipconfig` in CMD:
2. The expected IPv4 results are:
IP Address......................: 192.168.0.3
Subnet Mask.....................: 255.255.255.0
Default Gateway.................: 192.168.0.1
   
## Basic router configuration
### R1
1. Make a console connection to R1
2. Press enter and use 'cisco' (without quotes) as password to access user exec mode.
3. Type `enable` and use 'class' (without quotes) as password to access priviliged exec mode.
4. Type `show running-config`.
5. The following output is expected:
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

## Basic switch configuration
### S1
1. Make a console connection to S1
2. Press enter to access user exec mode.
3. Type `enable` to access priviliged exec mode.
4. Type `ip interface brief`.
5. The following output is expected:
Interface              IP-Address      OK? Method Status                Protocol 
FastEthernet0/1        unassigned      YES manual down                  down 
FastEthernet0/2        unassigned      YES manual down                  down 
FastEthernet0/3        unassigned      YES manual down                  down 
FastEthernet0/4        unassigned      YES manual down                  down 
FastEthernet0/5        unassigned      YES manual up                    up 
FastEthernet0/6        unassigned      YES manual up                    up 
FastEthernet0/7        unassigned      YES manual down                  down 
FastEthernet0/8        unassigned      YES manual down                  down 
FastEthernet0/9        unassigned      YES manual down                  down 
FastEthernet0/10       unassigned      YES manual down                  down 
FastEthernet0/11       unassigned      YES manual down                  down 
FastEthernet0/12       unassigned      YES manual down                  down 
FastEthernet0/13       unassigned      YES manual down                  down 
FastEthernet0/14       unassigned      YES manual down                  down 
FastEthernet0/15       unassigned      YES manual down                  down 
FastEthernet0/16       unassigned      YES manual down                  down 
FastEthernet0/17       unassigned      YES manual down                  down 
FastEthernet0/18       unassigned      YES manual down                  down 
FastEthernet0/19       unassigned      YES manual down                  down 
FastEthernet0/20       unassigned      YES manual down                  down 
FastEthernet0/21       unassigned      YES manual down                  down 
