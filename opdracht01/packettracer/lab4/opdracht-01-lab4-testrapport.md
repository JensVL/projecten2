# Testrapport Opdracht 1: labo 4 

## Test 1

Uitvoerder(s) test: Olivier De Vriese  
Uitgevoerd op: 22/02/2019  
Github commit:  88f77c61b8f71933ec8daa14f24130d9509a0551

## Basic router configuration
### Router 1
Alles vlot verlopen volgens het testplan.

### Router 2
Alles vlot verlopen volgens het testplan.

### Router 3

3. Type `show ip interface brief`. The following output is expected:  

| Interface | IP-Address | OK? | Method | Status | Protocol |
|---|---|---|---|---|---|
| Serial0/0/0 | 172.16.2.1 | YES | unset | administratively down | down |


Het verwachte IP-Address van Serial 0/0/0 moest 172.16.2.1 zijn, maar was in realiteit unassigned  
Voor de rest was alles in orde.


## Basic PC configuration
### PC 1
De output komt overeen met wat verwacht werd. 

### PC 2
Vermoedelijke typfout bij stap 1, indien PC2 bedoeld wordt in plaats van PC1 dan komt de output overeen met wat verwacht werd.

### PC 3
Idem fout als hierboven, indien PC3 bedoeld wordt in plaats van PC1 dan komt de output overeen met wat verwacht werd.


## Console line
### PC 1 to Router 1
De connectie kwam succesvol tot stand, maar het testplan vermelde niet welke prompt getoond moest worden.  
(zie stap 6 testplan)

### PC 2 to Router 2
De connectie kwam succesvol tot stand, maar het testplan vermelde niet welke prompt getoond moest worden.  
(zie stap 6 testplan)

### PC 3 to Router 3
De connectie kwam succesvol tot stand, maar het testplan vermelde niet welke prompt getoond moest worden.  
(zie stap 6 testplan)


## Encrypted passwords
### Router 1
De wachtwoorden voor router 1 tot en met 3 zijn succesvol geëncrypteerd.  


## Static routes
Alle pings waren vanop elke PC succesvol.
