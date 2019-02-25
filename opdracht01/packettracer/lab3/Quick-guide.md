# Labo 3: Quick guide
## Fysieke opstelling
1. Verbind PC-A met de switch door middel van een straight-through ethernet kabel. Op PC-A gebruik je de FastEthernet0 poort en op de switch de FastEthernet0/6 poort.

2. Verbind je de switch met de router door middel van een straight-through ethernet kabel. Op de switch gebruik je de FastEthernet0/5 poort, en op de router de GigabitEthernet0/1 poort.

3. Verbind je de router met PC-B door middel van een cross-over ethernet kabel.
Op de router gebruik je de GigabitEthernet0/0 poort en op PC-B de FastEthernet0 poort.

4. Zet alle toestellen aan.

## PC Configuratie
### PC-A
1. Typ bij windows zoeken “configuratiescherm” in
2. Klik op “Netwerk en Internet”
3. Klik op “Netwerkcentrum”
4. Klik op de verbinding onder toegangstype: Internet
5. Klik op “Eigenschappen”
6. Klik op “Internet Protocol versie 4 (TCP/IPv4)” en nadien op “Eigenschappen”
7. Vul volgende gegevens in:
    ```
    IP-adres: 192.168.1.3
    Subnetmasker: 255.255.255.0
    Standaardgateway: 192.168.1.1
    ```

### PC-B
1. Typ bij windows zoeken “configuratiescherm” in
2. Klik op “Netwerk en Internet”
3. Klik op “Netwerkcentrum”
4. Klik op de verbinding onder toegangstype: Internet
5. Klik op “Eigenschappen”
6. Klik op “Internet Protocol versie 4 (TCP/IPv4)” en nadien op “Eigenschappen”
7. Vul volgende gegevens in: 
    ```
    IP-adres: 192.168.0.3
    Subnetmasker: 255.255.255.0
    Standaardgateway: 192.168.0.1
    ```

## Router configuration 
1. Gebruik puTTY om een consoleconnectie te maken tussen R1 en PC-B.
2. Kopieer volgende tekst in de console connectie:
    ```
    enable
    configure terminal
    hostname R1
    no ip domain-lookup
    enable secret class
    line console 0
    password cisco
    login
    line vty 0 4
    password cisco
    login
    exit
    service password-encryption
    banner motd #Unauthorized access is strictly prohibited and prosecuted to the full extend of the law. #
    interface G0/0
    ip address 192.168.0.1 255.255.255.0
    no shutdown
    description This interface is connected to PC-B
    interface G0/1
    ip address 192.168.1.1 255.255.255.0
    no shutdown
    description This interface is connected to the switch
    exit
    exit
    copy running-config startup-config // press enter
    clock set <uur>:<minuten>:<seconden> <maand> <datum> <jaar>
    ```