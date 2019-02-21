# Testplan: Opdracht 1
*Author: Nathan Cammerman, Matthias Van De Velde*

## Basic router configuration
### Router 1
1. Press enter and use 'admin' (without quotes) to gain access to user exec mode.
2. Type `enable` to access privileged exec mode.
3. Type `show ip interface brief`. You should see the following.

| Interface | IP-Address | OK? | Method | Status | Protocol |
|---|---|---|---|---|---|
| GigabitEthernet0/0 | 172.16.3.1 | YES | manual | up | up |
| GigabitEthernet0/1 | unassigned  | YES | unset |administratively down | down |
| Serial0/0/0 | 172.16.2.1 | YES | manual | up | up |
| Serial0/0/1 | unassigned | YES | unset | administratively down | down |
| Vlan1 | unassigned | YES | unset | administratively down | down |

4. Type `show ip route`. Your should see only the following lines.  
C       172.16.2.0/24 is directly connected, Serial0/0/0  
L       172.16.2.1/32 is directly connected, Serial0/0/0  
C       172.16.3.0/24 is directly connected, GigabitEthernet0/0  
L       172.16.3.1/32 is directly connected, GigabitEthernet0/0  

### Router 2
1. Press enter and use 'admin' (without quotes) to gain access to user exec mode.
2. Type `enable` to access privileged exec mode.
3. Type `show ip interface brief`. You should see the following.

| Interface | IP-Address | OK? | Method | Status | Protocol |
|---|---|---|---|---|---|
| GigabitEthernet0/0 | 172.16.1.1 | YES | manual | up | up |
| GigabitEthernet0/1 | unassigned  | YES | unset |administratively down | down |
| Serial0/0/0 | 172.16.2.2 | YES | manual | up | up |
| Serial0/0/1 | 192.168.1.2 | YES | manual | up | up |
| Vlan1 | unassigned | YES | unset | administratively down | down |

4. Type `show ip route`. Your should see only the following lines.  
C       172.16.1.0/24 is directly connected, GigabitEthernet0/0  
L       172.16.1.1/32 is directly connected, GigabitEthernet0/0  
C       172.16.2.0/24 is directly connected, Serial0/0/0  
L       172.16.2.2/32 is directly connected, Serial0/0/0  
S       172.16.3.0/24 is directly connected, Serial0/0/0  
C       192.168.1.0/24 is directly connected, Serial0/0/1  
L       192.168.1.2/32 is directly connected, Serial0/0/1  
S    192.168.2.0/24 [1/0] via 192.168.1.1  
### Router 3
1. Press enter and use 'admin' (without quotes) to gain access to user exec mode.
2. Type `enable` to access privileged exec mode.
3. Type `show ip interface brief`. You should see the following.

| Interface | IP-Address | OK? | Method | Status | Protocol |
|---|---|---|---|---|---|
| GigabitEthernet0/0 | 192.168.2.1 | YES | manual | up | up |
| GigabitEthernet0/1 | unassigned  | YES | unset |administratively down | down |
| Serial0/0/0 | 172.16.2.1 | YES | unset | administratively down | down |
| Serial0/0/1 | 192.168.1.1 | YES | unset | up | up |
| Vlan1 | unassigned | YES | unset | administratively down | down |

4. Type `show ip route`. Your should see only the following lines.  
S       172.16.0.0/22 [1/0] via 192.168.1.2  
C       192.168.1.0/24 is directly connected, Serial0/0/1  
L       192.168.1.1/32 is directly connected, Serial0/0/1  
C       192.168.2.0/24 is directly connected, GigabitEthernet0/0  
L       192.168.2.1/32 is directly connected, GigabitEthernet0/0  
