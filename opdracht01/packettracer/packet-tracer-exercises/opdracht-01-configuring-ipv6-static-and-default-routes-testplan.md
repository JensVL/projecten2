# Testplan: Packet Tracer - exercises

*Authors: Nathan Cammerman, Matthias Van De Velde*

## Configuring IPv6 Static and Default Routes
### R1 - recursive static route


### R2 - directly attached and fully specified route

### R3 - default route

### Static routing configurations

### Network connectivity


## Basic Switch Configuration
### Console connection
1. Click on PC student1
2. Go to Desktop > Terminal
3. Click OK
4. If you are not prompted to enter a password, the test failed. In this case, try to ping the IP-address and report the results 
(optional if step 4 was successful)
5. Login using'6EBUp' (without quotes)
6. You should now see the following prompt:
> TODO: add prompt


### Encrypted passwords
1. Go to privileged exec mode using 'xAw6k' (without quotes) as the password
2. Type `show running-config`
3. Search for all entries that look like either the first or the second example. If you notice one or more don't look alike, the password(s) is/are not encrypted. The test failed and you should report this
example 1: enable secret 5 $1$mERr$vTbHul1N28cEp8lkLqr0f/
example 2: password 7 082048430017  

### VLAN 1 interface
1. While still in privileged exec mode, type `show ip interface brief`
2. You should see the following output:
> TODO: add output

### Network connectivity
1. Click on PC student1
2. Go to Desktop > Command Prompt
3. Type `ipconfig`
4. If you don't see the following output, the test failed
> TODO: add output
(Only after step 4 was successful)
5. Type `ping 172.16.5.60`
6. If you see something similar to the following, the test was successful
> TODO: add output


1. Click on PC student2
2. Go to Desktop > Command Prompt
3. Type `ipconfig`
4. If you don't see the following output, the test failed
> TODO: add output
(Only after step 4 was successful)
5. Type `ping 172.16.5.50`
6. If you see something similar to the following, the test was successful
> TODO: add output





















