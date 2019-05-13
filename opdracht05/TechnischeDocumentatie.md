#Technische documentatie

Author: Nathan Cammerman

##Configureerbare componenten (vagrant-hosts.yml)

Verwijzing: Opdracht2/Documentatie_LAMP/LAMP-user-guide.md

##Opzetten van de VM's

Om de applicatieserver en de backup server op te starten, ga naar testomgeving van opdracht 5 in uw command prompt. Voer hierna volgende commandos uit.

Indien U een snapshot wil nemen van een net opgezette vm:
```
vagrant up --no-provision
vagrant snapshot save *gekozen naam voor snapshot*
vagrant provision
```

Indien U alles in 1 keer wilt uitvoeren:
```
vagrant up 
```