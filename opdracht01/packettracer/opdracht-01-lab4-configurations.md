#Routee Configurations
password: admin  
admin password: admin  
console line 0 password: admin  
vty line 0-4 password: admin  

## Router 1
```
Current configuration : 1061 bytes
!
version 15.1
no service timestamps log datetime msec
no service timestamps debug datetime msec
no service password-encryption
!
hostname R1
!
!
!
enable secret 5 $1$mERr$vTbHul1N28cEp8lkLqr0f/
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
license udi pid CISCO1941/K9 sn FTX15245N14-
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
 ip address 172.16.3.1 255.255.255.0
 duplex auto
 speed auto
!
interface GigabitEthernet0/1
 no ip address
 duplex auto
 speed auto
 shutdown
!
interface Serial0/0/0
 ip address 172.16.2.1 255.255.255.0
 clock rate 64000
!
interface Serial0/0/1
 no ip address
 clock rate 2000000
 shutdown
!
interface Vlan1
 no ip address
 shutdown
!
ip classless
ip route 192.168.2.0 255.255.255.0 192.168.1.1 
ip route 0.0.0.0 0.0.0.0 172.16.2.2 
!
ip flow-export version 9
!
!
!
!
!
!
!
!
line con 0
 exec-timeout 0 0
 password admin
 logging synchronous
 login
!
line aux 0
!
line vty 0 4
 exec-timeout 0 0
 password admin
 logging synchronous
 login
line vty 5 12
 login
!
!
!
end
```

## Router 2
```
Current configuration : 1025 bytes
!
version 15.1
no service timestamps log datetime msec
no service timestamps debug datetime msec
no service password-encryption
!
hostname R2
!
!
!
enable secret 5 $1$mERr$vTbHul1N28cEp8lkLqr0f/
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
license udi pid CISCO1941/K9 sn FTX1524L3FC-
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
 ip address 172.16.1.1 255.255.255.0
 duplex auto
 speed auto
!
interface GigabitEthernet0/1
 no ip address
 duplex auto
 speed auto
 shutdown
!
interface Serial0/0/0
 ip address 172.16.2.2 255.255.255.0
!
interface Serial0/0/1
 ip address 192.168.1.2 255.255.255.0
!
interface Vlan1
 no ip address
 shutdown
!
ip classless
ip route 192.168.2.0 255.255.255.0 192.168.1.1 
ip route 172.16.3.0 255.255.255.0 Serial0/0/0 
!
ip flow-export version 9
!
!
!
!
!
!
!
!
line con 0
 exec-timeout 0 0
 password admin
 logging synchronous
 login
!
line aux 0
!
line vty 0 4
 exec-timeout 0 0
 password admin
 logging synchronous
 login
!
!
!
end
```

# Router 3
```
Current configuration : 1004 bytes
!
version 15.1
no service timestamps log datetime msec
no service timestamps debug datetime msec
no service password-encryption
!
hostname R3
!
!
!
enable secret 5 $1$mERr$vTbHul1N28cEp8lkLqr0f/
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
license udi pid CISCO1941/K9 sn FTX1524LM98-
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
 ip address 192.168.2.1 255.255.255.0
 duplex auto
 speed auto
!
interface GigabitEthernet0/1
 no ip address
 duplex auto
 speed auto
 shutdown
!
interface Serial0/0/0
 no ip address
 clock rate 2000000
 shutdown
!
interface Serial0/0/1
 ip address 192.168.1.1 255.255.255.0
 clock rate 64000
!
interface Vlan1
 no ip address
 shutdown
!
ip classless
ip route 172.16.0.0 255.255.252.0 192.168.1.2 
!
ip flow-export version 9
!
!
!
!
!
!
!
!
line con 0
 exec-timeout 0 0
 password admin
 logging synchronous
 login
!
line aux 0
!
line vty 0 4
 exec-timeout 0 0
 password admin
 logging synchronous
 login
!
!
!
end
```
