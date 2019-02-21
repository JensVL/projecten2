# Cheat sheet: IOS Commands
## General useful commands
1. Secure console line
```
Router(config)# line console <0-9>
Router(config-line)# password <password>
Router(config-line)# login
Router(config-line)# logging synchronous
```


2. Secure vty interface
```
Router(config)# line vty <0-15>
Router(config-line)# password <password>
Router(config-line)# login
Router(config-line)# logging synchronous
```

3. Encrypt passwords
```
Router(config)# service password-encryption
```

4. Save running config
```
Router(config)# copy running-config startup-config
```

## Configure IPv6 static and default routes
### Enable IPv6 routing
```
Router(config)# ipv6 unicast-routing
```

### Add static route  
Use either the next hop for a recursive route or an exit interface for a direct route.
```
Router(config)# [ipv6] route <destination network> <subnet mask> <next hop IP address | exit interface>
```
If you want a fully specified static route, use the exit interface and the naxt hop address together
```
Router(config)# [ipv6] route <destination network> <subnet mask> <exit interface> <next hop IP address>
```

### Add default route
1. IPv4
```
Router(config)# route 0.0.0.0 0.0.0.0 <destination IP address>
```
2. IPv6
```
Router(config)# ipv6 route ::/0 <destination IP address>
```

### Verify static route configurations
1. PC configuration
```
C:\ ip[v6]config
```
2. Interface addresses on the router
```
Router(config)# show ip[v6] interface brief
```
3. Routing table content
```
Router(config)# show ip[v6] route
```




## Basic configuration switch
### Change MOTD banner
```
Router(config)# banner motd #Here goes your message#
```
### Configure VLAN
```
Router(config)# interface vlan1
Router(config-if)# ip address <IP address> <subnet mask>
Router(config-if)# interface vlan1
Router(config-if)# no shutdown
```

