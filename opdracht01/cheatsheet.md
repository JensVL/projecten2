# Cheat sheet: IOS Commands
## General useful commands
1. Secure console line
```Markdown
Router(config)# line console <0-9>
Router(config-line)# password <password>
Router(config-line)# login
Router(config-line)# logging synchronous
```


2. Secure vty interface
```Markdown
Router(config)# line vty <0-15>
Router(config-line)# password <password>
Router(config-line)# login
Router(config-line)# logging synchronous
```

3. Encrypt passwords
```Markdown
Router(config)# service password-encryption
```

4. Save running config
```Markdown
Router(config)# copy running-config startup-config
```

## Configure IPv6 static and default routes
### Enable IPv6 routing
```Markdown
Router(config)# ipv6 unicast-routing
```

### Add static route  
Use either the next hop for a recursive route or an exit interface for a direct route.

```Markdown
Router(config)# [ipv6] route <destination network> <subnet mask> <next hop IP address | exit interface>
```

If you want a fully specified static route, use the exit interface and the naxt hop address together

```Markdown
Router(config)# [ipv6] route <destination network> <subnet mask> <exit interface> <next hop IP address>
```

### Add default route
1. IPv4
```Markdown
Router(config)# route 0.0.0.0 0.0.0.0 <destination IP address>
```
2. IPv6
```Markdown
Router(config)# ipv6 route ::/0 <destination IP address>
```

### Add summary route
If you have 2 or more networks close together you can add a summary route instead of one or more static routes to reduce the size of the routing table.
1. Transform the networks into binary.
2. Find a common part from left to right among all the networks.
3. The left part with all the bits from the right part set to zero will become the network.
4. The left part with all its bits set to one will become the subnet mask.  

Example:  
172.16.1.0 ------ **10101100.00010000.000000**01.00000000  
172.16.2.0 ------ **10101100.00010000.000000**10.00000000  
172.16.3.0 ------ **10101100.00010000.000000**11.00000000

Network: 172.16.0.0 ------ 10101100.00010000.000000**00.00000000**  
Subnet mask: 255.255.252.0 ------ **11111111.11111111.111111**00.00000000  

### Verify static route configurations
1. PC configuration
```Markdown
C:\ ip[v6]config
```
2. Interface addresses on the router
```Markdown
Router(config)# show ip[v6] interface brief
```
3. Routing table content
```Markdown
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

