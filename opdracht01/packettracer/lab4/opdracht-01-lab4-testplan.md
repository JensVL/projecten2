# Testplan: Opdracht 1
*Authors: Nathan Cammerman, Matthias Van De Velde*

## Basic router configuration
### Router 1
1. Press enter and use 'admin' (without quotes) to gain access to user exec mode.
2. Type `enable` to access privileged exec mode.
3. Type `show ip interface brief`. The following output is expected:  

| Interface | IP-Address | OK? | Method | Status | Protocol |
|---|---|---|---|---|---|
| GigabitEthernet0/0 | 172.16.3.1 | YES | manual | up | up |
| GigabitEthernet0/1 | unassigned  | YES | unset |administratively down | down |
| Serial0/0/0 | 172.16.2.1 | YES | manual | up | up |
| Serial0/0/1 | unassigned | YES | unset | administratively down | down |
| Vlan1 | unassigned | YES | unset | administratively down | down |

4. Type `show ip route`. The following output is expected:  
C       172.16.2.0/24 is directly connected, Serial0/0/0  
L       172.16.2.1/32 is directly connected, Serial0/0/0  
C       172.16.3.0/24 is directly connected, GigabitEthernet0/0  
L       172.16.3.1/32 is directly connected, GigabitEthernet0/0 

### Router 2
1. Press enter and use 'admin' (without quotes) to gain access to user exec mode.
2. Type `enable` to access privileged exec mode.
3. Type `show ip interface brief`. The following output is expected:  

| Interface | IP-Address | OK? | Method | Status | Protocol |
|---|---|---|---|---|---|
| GigabitEthernet0/0 | 172.16.1.1 | YES | manual | up | up |
| GigabitEthernet0/1 | unassigned  | YES | unset |administratively down | down |
| Serial0/0/0 | 172.16.2.2 | YES | manual | up | up |
| Serial0/0/1 | 192.168.1.2 | YES | manual | up | up |
| Vlan1 | unassigned | YES | unset | administratively down | down |

4. Type `show ip route`. The following output is expected:  
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
3. Type `show ip interface brief`. The following output is expected:  

| Interface | IP-Address | OK? | Method | Status | Protocol |
|---|---|---|---|---|---|
| GigabitEthernet0/0 | 192.168.2.1 | YES | manual | up | up |
| GigabitEthernet0/1 | unassigned  | YES | unset |administratively down | down |
| Serial0/0/0 | 172.16.2.1 | YES | unset | administratively down | down |
| Serial0/0/1 | 192.168.1.1 | YES | unset | up | up |
| Vlan1 | unassigned | YES | unset | administratively down | down |

4. Type `show ip route`. The following output is expected:  
S       172.16.0.0/22 [1/0] via 192.168.1.2  
C       192.168.1.0/24 is directly connected, Serial0/0/1  
L       192.168.1.1/32 is directly connected, Serial0/0/1  
C       192.168.2.0/24 is directly connected, GigabitEthernet0/0  
L       192.168.2.1/32 is directly connected, GigabitEthernet0/0  


## Basic PC configuration
### PC 1
1. Click on PC1.
2. Go to Destop > Command Prompt.
3. Type `ipconfig`.
4. The following output is expected:  
FastEthernet0 Connection:(default port)  
Link-local IPv6 Address...: FE80::2E0:F9FF:FE15:4168  
IP Address.............................: 172.16.3.10  
Subnet Mask........................: 255.255.255.0  
Default Gateway.................: 172.16.3.1  

### PC 2
1. Click on PC1.
2. Go to Destop > Command Prompt.
3. Type `ipconfig`.
4. The following output is expected:  
FastEthernet0 Connection:(default port)  
Link-local IPv6 Address...: FE80::202:4AFF:FE9C:D536  
IP Address.............................: 172.16.1.10  
Subnet Mask........................: 255.255.255.0  
Default Gateway.................: 172.16.1.1  

### PC 3
1. Click on PC1.
2. Go to Destop > Command Prompt.
3. Type `ipconfig`.
4. The following output is expected:  
FastEthernet0 Connection:(default port)  
Link-local IPv6 Address...: FE80::201:63FF:FE2B:8DA6  
IP Address.............................: 192.168.2.10  
Subnet Mask........................: 255.255.255.0  
Default Gateway.................: 192.168.2.1  


## Console line
### PC 1 to Router 1
1. Click on PC1.
2. Go to Destop > Command Prompt.
3. Type `telnet 172.16.3.1`.
4. If you are not prompted to enter a password, the test failed. If the connection failed, try to ping the IP-address and report the results.  
(optional if step 4 was successful)
5. Enter the password 'admin' (without quotes).
6. If you see the following prompt, the connection was successful.

### PC 2 to Router 2
1. Click on PC2.
2. Go to Destop > Command Prompt.
3. Type `telnet 172.16.1.1`.
4. If you are not prompted to enter a password, the test failed. If the connection failed, try to ping the IP-address and report the results.  
(optional if step 4 was successful)
5. Enter the password 'admin' (without quotes).
6. If you see the following prompt, the connection was successful.

### PC 3 to Router 3
1. Click on PC3.
2. Go to Destop > Command Prompt.
3. Type `telnet 192.168.2.1`.
4. If you are not prompted to enter a password, the test failed. If the connection failed, try to ping the IP-address and report the results.  
(optional if step 4 was successful)
5. Enter the password 'admin' (without quotes).
6. If you see the following prompt, the connection was successful.


## Encrypted passwords
### Router 1
1. Click on Router 1 and go to privileged exec mode.
2. Type `show running-config`.
3. Search for all entries that look like either the first or the second example. If you notice one or more don't look alike, the password(s) is/are not encrypted. The test failed and you should report this.  

> example 1: enable secret 5 $1$mERr$vTbHul1N28cEp8lkLqr0f/  
> example 2: password 7 082048430017  

4. Repeat this for Router 2 and Router 3.  


## Static routes
### PC 1
1. Click on PC1.
2. Go to Destop > Command Prompt.
3. Use `ping` to try and reach all the IP-addresses listed below.  

| Device | IP-Address |
|---|---|
| Router 1 | 172.16.3.1 |
| Router 2 | 172.16.1.1 |
| Router 3 | 192.168.2.1 |
| PC 1 | 172.16.3.10 |
| PC 2 | 172.16.1.10 |
| PC 3 | 192.168.2.10 |

4. Repeat this for PC 2 and 3.
5. If one or more fail, report this.