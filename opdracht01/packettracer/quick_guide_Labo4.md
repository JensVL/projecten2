# Quick guide Labo4

## Task 1: Cable, Erase, and Reload the Routers.

- Stap 1: bekabel een netwerk dat lijkt op de gegeven topology.

Maak hiervoor gebruik van de "end devices", "network devices" en "connections" links onderaan het scherm in packet tracer.

- Stap 2: Wis de configuratie van elke router.

Commando's: 
- erase startup-config
- reload (dan "no")

## Task 2: Basische router configuratie.

- Global configuratie + console & virtuele lijnen passwoord toekennen 

Startend van een net geopende CLI:

Commando's:
- enable
- configure terminal
- hostname R1
- no ip domaon lookup
- enable secret admin
- line vty 0 4
- password admin
- login
- logging synchronous
- exec-timeout 0 0
- exit
- line console 0 
- password admin
- login
- logging synchronous
- exec-timeout 0 0


## Task 3: Debug output interpreteren.

Startend van een net geopende CLI:

Commando's:
- enable
- debug ip routing
- configure terminal
- interface gigabitethernet0/0
- ip address 172.16.3.1 255.255.255.0
- no shutdown
- decription XXXXX

(Als er geen debug output is moet je eens de commando’s shut en no shutdown na elkaar doen in dezelfde interface.

Commando om te zien of het effectief is toegevoegd aan de routing table

- show ip route )

- exit
- interface serial0/0/0
- ip address 172.16.2.1 255.255.255.0 
- clock rate 64000 
(clock rate moet je maar bij 1 van de 2 connecties specifiëren van de seriële verbinding)
- no shutdown 
- decription XXXXX

[Complimentary router zodat we output van router 1 kunnen observeren wanneer we aanpassingen maken op router 2]

- enable
- debug ip routing
- configure terminal
- interface serial 0/0/0
- ip address 172.16.2.2 255.255.255.0 
- no shutdown
- exit
- exit
- show ip route

Na configuratie van elke router:
- enable
- no debug ip routing


## Task 4: Router interface configuratie afwerken.

Herhaal Task 3 voor alle routers.


## Task 5: Configuratie IP address op host PC.

- PC1
- Desktop
- ip configuration
- vul het ip address, subnetmask en default gateway in.

## Task 6: Test en Verify de Configuraties.

- ping van elke host naar de default gateway
- ping van router 2 naar router 1 en 3

Deze pings zijn nog niet mogelijk:
- PC3 -> PC1
- PC3 -> PC2
- PC2 -> PC1
- Router 1 -> Router 3

## Task 7: Info verzamelen.

Commando's:
- show ip interface brief
- show ip route

## Task 8: Configuratie static route gebruikmakend van next-hop adres.

Commando's:
- enable
- configure terminal
- ip route 172.16.1.0 255.255.255.0 192.168.1.2

[complementary router]

- enable
- configure terminal
- ip route 192.168.2.0 255.255.255.0 192.168.1.1


## Task 9: Configureer een static route gebruikmakend van een exit interface.

Commando's:

- enable
- configure terminal
- ip route 172.16.2.0 255.255.255.0 Serial0/0/1

Router 2:

- enable
- configure terminal
- ip route 172.16.3.0 255.255.255.0 Serial0/0/0


## Task 10: Default static route.

- enable
- configure terminal
- ip route 0.0.0.0 0.0.0.0 172.16.2.2


## Task 11: Configureer een Summary Static Route.

Commando's:

- enable
- configure terminal
- ip route 172.16.0.0 255.255.252.0 192.168.1.2

Bepaalde routes moeten dus verwijderd worden nadat een summary static route is gecreëerd.

- no ip route 172.16.1.0 255.255.255.0 192.168.1.2
- no ip route 172.16.2.0 255.255.255.0 serial0/0/0
