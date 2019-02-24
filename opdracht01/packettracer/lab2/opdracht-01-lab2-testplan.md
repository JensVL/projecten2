# Testplan: Opdracht-01-lab2-testplan
*Author: Olivier De Vriese*

## Basic PC configuration
### PC 1
1. Click on PC-A.
2. Go to Destop > Command Prompt.
3. Type `ipconfig`.
4. The following output is expected:  
FastEthernet0 Connection:(default port)  
Link-local IPv6 Address...: FE80::20A:41FF:FEE8:9544  
IP Address.............................: 192.168.1.10  
Subnet Mask........................: 255.255.255.0  
Default Gateway.................: 0.0.0.0  

### PC 2
1. Click on PC-B.
2. Go to Destop > Command Prompt.
3. Type `ipconfig`.
4. The following output is expected:  
FastEthernet0 Connection:(default port)  
Link-local IPv6 Address...: FE80::2E0:F9FF:FE70:E89C  
IP Address.............................: 192.168.1.11  
Subnet Mask........................: 255.255.255.0  
Default Gateway.................: 0.0.0.0  

## Connection test
### PC-A
1. Click on PC-A.
2. Go to Destop > Command Prompt.
3. Use `ping 192.168.1.11` to try and reach PC-B. 

### PC-B
1. Click on PC-B.
2. Go to Destop > Command Prompt.
3. Use `ping 192.168.1.10` to try and reach PC-A.

## Basic Switch Configuration
### S1
1. Click on Switch 1 and use `cisco` without the quotes.
2. Type enable and use `class` without quotes to go to global configuration mode.
3. Type `show running-config`.
4. The folowwing output is expected:  
Current configuration : 1270 bytes  
!  
version 12.2  
no service timestamps log datetime msec  
no service timestamps debug datetime msec  
no service password-encryption  
!  
hostname S1  
!  
enable secret 5 $1$mERr$9cTjUIEqNGurQiFU.ZeCi1  
!  
!  
!  
no ip domain-lookup  
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
banner motd ^CUnauthorized access is strictly prohibited and prosecuted to the full extend of the law. ^C  
!  
!  
!  
line con 0  
 password cisco  
 login  
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
5. type `show version` and look for the following output:  

|Switch | Ports | Model | SW Version | SW Image | 
| --- | --- | --- | --- | --- |
| 1 | 26 | WS-C2960-24TT | 12.2 | C2960- |

6. type `show ip interface brief` and look for the interfaces **FastEthernet0/1** and **FastEthernet0/6**.  
They should be the only 2 interfaces with status **up**.

### S2
1. Click on Switch 2 and use `cisco` without the quotes.
2. Type enable and use `class` without quotes to go to global configuration mode.
3. Type `show running-config`.
4. The folowwing output is expected:  
Current configuration : 1270 bytes  
!  
version 12.2  
no service timestamps log datetime msec  
no service timestamps debug datetime msec  
no service password-encryption  
!  
hostname S2  
!  
enable secret 5 $1$mERr$9cTjUIEqNGurQiFU.ZeCi1  
!  
!  
!  
no ip domain-lookup  
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
banner motd ^CUnauthorized access is strictly prohibited and prosecuted to the full extend of the law. ^C  
!  
!  
!  
line con 0  
 password cisco  
 login  
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
5. type `show version` and look for the following output:  

|Switch | Ports | Model | SW Version | SW Image | 
| --- | --- | --- | --- | --- |
| 1 | 26 | WS-C2960-24TT | 12.2 | C2960- |

6. type `show ip interface brief` and look for the interfaces **FastEthernet0/1** and **FastEthernet0/18**.  
They should be the only 2 interfaces with status **up**.
