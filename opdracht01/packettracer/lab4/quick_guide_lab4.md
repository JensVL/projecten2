# Quick guide Labo4

## Cable, Erase, and Reload the Routers.
* 2 serial cables
* 7 ethernet cables(6 + 1 console)
* 1 console-usb cable

```Markdown
Router# erase startup-config 
Router# reload
```

## Basic router config
> Repeat this for every router
```Markdown
Router(config)# hostname <Router name>

Router(config)# no ip domain lookup

Router(config)# enable secret

Router(config)# line console 0
Router(config-line)# password <password>
Router(config-line)# login
Router(config-line)# logging synchronous
Router(config-line)# exec-timeout <minutes> <seconds>

Router(config)# line vty 0 4
Router(config-line)# password <password>
Router(config-line)# login
Router(config-line)# logging synchronous
Router(config-line)# exec-timeout <minutes> <seconds>
```

### Configurations
#### Router1
```
enable  
configure terminal  
hostname R1  
no ip domain lookup  
enable secret admin  

line console 0  
password admin  
login  
logging synchronous  
exec-timeout 0 50  
exit  
line vty 0 4  
password admin  
login  
logging synchronous  
exec-timeout 0 50  
exit  
``` 


#### Router2
```
enable  
configure terminal  
hostname R2   
no ip domain lookup  
enable secret admin  

line console 0  
password admin  
login  
logging synchronous  
exec-timeout 0 50  
exit  
line vty 0 4  
password admin  
login  
logging synchronous  
exec-timeout 0 50  
exit  
```

#### Router3
```
enable  
configure terminal  
hostname R3   
no ip domain lookup  
enable secret admin  

line console 0  
password admin  
login  
logging synchronous  
exec-timeout 0 50  
exit  
line vty 0 4  
password admin  
login  
logging synchronous  
exec-timeout 0 50  
exit  
```

## Interface configurations
> Repeat this for every router
```Markdown 
Router# debug ip routing
Router# configure terminal
Router(config)# interface <interface>
Router(config-if)# ip address <ip address> <subnet mask>
Router(config-if)# no shutdown
```

### Configurations
#### Router1
```
debug ip routing  
configure terminal  
interface GigabitEthernet0/0/0  
ip address 172.16.3.1 255.255.255.0  
no shutdown  
exit  

interface Serial0/1/0  
ip address 172.16.2.1 255.255.255.0  
clock rate 64000  
no shutdown  
end  
no debug ip routing  
```

#### Router2
```
debug ip routing  
configure terminal  
interface GigabitEthernet0/0/0  
ip address 172.16.1.1 255.255.255.0  
no shutdown  
exit  

interface Serial0/1/0  
ip address 172.16.2.2 255.255.255.0  
clock rate 64000  
no shutdown  
exit

interface Serial0/1/1  
ip address 192.168.1.2 255.255.255.0  
clock rate 64000  
no shutdown  
end  
no debug ip routing  
``` 


#### Router3
```
debug ip routing  
configure terminal  
interface GigabitEthernet0/0/0  
ip address 192.168.2.1 255.255.255.0  
no shutdown  
exit  

interface Serial0/1/1  
ip address 192.168.1.1 255.255.255.0  
clock rate 64000  
no shutdown  
end  
no debug ip routing  
```

> connect pc through ethernet with all switches and ping routers

## Static routes
```Markdown
configure terminal
ip route <ip-address> <subnet mask> <next-hop-address | exit interface>

no ip route <ip-address> <subnet mask> <next-hop-address | exit interface>
```

### Configurations
#### Router1
```
configure terminal  
ip route 0.0.0.0 0.0.0.0 172.16.2.2  
```

#### Router2
```
configure terminal  
ip route 192.168.2.0 255.255.255.0 192.168.1.1  
ip route 172.16.3.0 255.255.255.0 Serial0/1/0
```

#### Router3
```
configure terminal   
ip route 172.16.0.0 255.255.252.0 192.168.1.2  
```

> ping everything from everywhere  

## Erase configurations
```Markdown
Router# erase startup-config 
Router# reload
```