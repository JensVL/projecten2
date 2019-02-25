# Testplan: Packet Tracer exercises

*Authors: Nathan Cammerman, Matthias Van De Velde*

## Configuring IPv6 Static and Default Routes
Open *2.2.4.4 Packet Tracer - Configuring IPv6 Static and Default Routes(solution).pka*

### Routes in R1
1. Go to privileged exec mode (enable) and type `show ipv6 route`
2. The following lines should at least occur in the output:
```Markdown
S   2001:DB8:1:2::/64 [1/0] via 2001:DB8:1:A001::2
S   2001:DB8:1:3::/64 [1/0] via 2001:DB8:1:A001::2
S   2001:DB8:1:A002::/64 [1/0] via 2001:DB8:1:A001::2
```

### Routes in R2
1. Go to privileged exec mode (enable) and type `show ipv6 route`
2. The following lines should at least occur in the output:
```Markdown
S   2001:DB8:1:1::/64 [1/0] via Serial0/0/0, directly connected
S   2001:DB8:1:3::/64 [1/0] via 2001:DB8:1:A002::2, Serial0/0/1
```

### Routes in R3
1. Go to privileged exec mode (enable) and type `show ipv6 route`
2. The following lines should at least occur in the output:
```Markdown
S   ::/0 [1/0] via 2001:DB8:1:A002::1
```

### R1 Interfaces
```Markdown
GigabitEthernet0/0         [up/up]
    FE80::1
    2001:DB8:1:1::1
GigabitEthernet0/1         [administratively down/down]
    unassigned
Serial0/0/0                [up/up]
    FE80::1
    2001:DB8:1:A001::1
Serial0/0/1                [administratively down/down]
    unassigned
Vlan1                      [administratively down/down]
    unassigned
```

### R2 Interfaces
GigabitEthernet0/0         [up/up]
    FE80::2
    2001:DB8:1:2::1
GigabitEthernet0/1         [administratively down/down]
    unassigned
Serial0/0/0                [up/up]
    FE80::2
    2001:DB8:1:A001::2
Serial0/0/1                [up/up]
    FE80::2
    2001:DB8:1:A002::1
Vlan1                      [administratively down/down]
    unassigned

### R3 Interfaces
```Markdown
GigabitEthernet0/0         [up/up]
    FE80::3
    2001:DB8:1:3::1
GigabitEthernet0/1         [administratively down/down]
    unassigned
Serial0/0/0                [administratively down/down]
    unassigned
Serial0/0/1                [up/up]
    FE80::3
    2001:DB8:1:A002::2
Vlan1                      [administratively down/down]
    unassigned
```

### Network connectivity
1. Click on PC1
2. Go to Destop > Command Prompt
3. Use `ping` to try and reach all the IP-addresses listed below. 

| Device | IP-Address |
|---|---|
| Router 1 | 2001:DB8:1:A001::1 |
| Router 2 | 2001:DB8:1:A002::1 |
| PC 1 | 2001:DB8:1:1::F |
| PC 2 | 2001:DB8:1:2::F |
| PC 3 | 2001:DB8:1:3::F |

4. Repeat this for PC 2 and 3
5. If one or more fail, report this

 
## Basic Switch Configuration
Open *opdracht-01-Packettracer - basisconfiguratie Switch (solution).pka*

### Console connection
1. Connect Student-1(RS 232) to Class-A(console) using a console cable 
2. Click on Student-1
3. Go to Desktop > Terminal
4. Click OK
5. If you are not prompted to enter a password, the test failed. In this case, try to ping the IP-address and report the results 
(optional if step 4 was successful)
6. Login using'xAw6k' (without quotes)
7. You should now see the following prompt:
```Markdown
Class-A>
```


### Encrypted passwords
1. Go to privileged exec mode (enable) using '6EBUp' (without quotes) as the password
2. Type `show running-config`
3. Search for all entries that look like either the first or the second example. If you notice one or more don't look alike, the password(s) is/are not encrypted. The test failed and you should report this
example 1: enable secret 5 $1$mERr$vTbHul1N28cEp8lkLqr0f/
example 2: password 7 082048430017  

### Interfaces
1. While still in privileged exec mode, type `show ip interface brief`
2. You should see the following output:
```Markdown
Interface              IP-Address      OK? Method Status                Protocol 
FastEthernet0/1        unassigned      YES manual up                    up 
FastEthernet0/2        unassigned      YES manual up                    up 
FastEthernet0/3        unassigned      YES manual down                  down 
... 
FastEthernet0/24       unassigned      YES manual down                  down 
GigabitEthernet0/1     unassigned      YES manual down                  down 
GigabitEthernet0/2     unassigned      YES manual down                  down 
Vlan1                  172.16.5.35     YES manual up                    up
```

### Network connectivity
1. Click on Student-1
2. Go to Desktop > Command Prompt
3. Type `ipconfig`
4. If you don't see the following output, the test failed
```Markdown
FastEthernet0 Connection:(default port)
   Link-local IPv6 Address.........: ::
   IP Address......................: 172.16.5.50
   Subnet Mask.....................: 255.255.255.0
   Default Gateway.................: 0.0.0.0
```
(Only after step 4 was successful)  
5. Type `ping 172.16.5.60`  
6. If you see something similar to the following, the test was successful
```
Pinging 172.16.5.60 with 32 bytes of data:

Reply from 172.16.5.60: bytes=32 time=2ms TTL=128
Reply from 172.16.5.60: bytes=32 time=1ms TTL=128
Reply from 172.16.5.60: bytes=32 time<1ms TTL=128
Reply from 172.16.5.60: bytes=32 time=2ms TTL=128

Ping statistics for 172.16.5.60:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 0ms, Maximum = 2ms, Average = 1ms
```



1. Click on Student-2
2. Go to Desktop > Command Prompt
3. Type `ipconfig`
4. If you don't see the following output, the test failed
```Markdown
FastEthernet0 Connection:(default port)
   Link-local IPv6 Address.........: ::
   IP Address......................: 172.16.5.60
   Subnet Mask.....................: 255.255.255.0
   Default Gateway.................: 0.0.0.0
```
(Only after step 4 was successful)  
5. Type `ping 172.16.5.50`  
6. If you see something similar to the following, the test was successful
```
Pinging 172.16.5.50 with 32 bytes of data:

Reply from 172.16.5.50: bytes=32 time<1ms TTL=128
Reply from 172.16.5.50: bytes=32 time=1ms TTL=128
Reply from 172.16.5.50: bytes=32 time<1ms TTL=128
Reply from 172.16.5.50: bytes=32 time<1ms TTL=128

Ping statistics for 172.16.5.50:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 0ms, Maximum = 1ms, Average = 0ms
```





















