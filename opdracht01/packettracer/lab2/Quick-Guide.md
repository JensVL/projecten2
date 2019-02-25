# Labo 1: Quick guide
## Fysieke opstelling
1. Verbind PC-A met S1 door middel van een straight-through ethernet kabel. Op PC-A gebruik je de FastEthernet0 poort en op S1 de FastEthernet0/6 poort.

2. Verbind S1 met S2 door middel van een cross-over kabel. Op S1 gebruik je de FastEthernet0/1 poort en op S2 de FastEthernet0/1 poort.

3. Verbind S2 met PC-B door middel van een straight-through kabel. Op S2 gebruik je de FastEthernet0/18 poort en op PC-B gebruik je de FastEthernet0 poort.

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
    IP-adres: 192.168.1.10
    Subnetmasker: 255.255.255.0
    Standaardgateway: 192.168.1.10
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
    IP-adres: 192.168.1.11
    Subnetmasker: 255.255.255.0
    Standaardgateway: 192.168.1.11
    ```

## Switch configuratie
### Switch 1
1. Gebruik puTTY om een consoleconnectie te maken tussen S1 en PC-B.
2. Kopieer volgende tekst in de console connectie:
    ```
    enable
    configure terminal
    hostname S1
    no ip domain-lookup
    enable secret class
    line console 0
    password cisco
    login 
    exit
    banner motd #Unauthorized access is strictly prohibited and prosecuted to the full extend of the law. #
    exit
    copy running-config startup-config
    ```
### Switch 2
1. Gebruik puTTY om een consoleconnectie te maken tussen S2 en PC-B.
2. Kopieer volgende tekst in de console connectie:
    ```
    enable
    configure terminal
    hostname S2
    no ip domain-lookup
    enable secret class
    line console 0
    password cisco
    login 
    exit
    banner motd #Unauthorized access is strictly prohibited and prosecuted to the full extend of the law. #
    exit
    copy running-config startup-config
    ```
