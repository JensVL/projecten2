# Testrapport Opdracht 2: LAMP-Stack

## Test 1

Uitvoerder(s) test: Jens Van Liefferinge
Uitgevoerd op: 19/03/2019
Github commit: 094c468

## Vagrant & Linux

1. VM succesvol gestart.
2. SSH verbinding gemaakt via gegeven commando. Prompt komt overeen met gegeven.
3. Commando `su` succesvol ingevoerd; prompt is veranderd naar gegeven.
4. SSH-sessie succesvol beëindigd.
5. SSH verbinding opgezet via PuTTY en gegeven info. Wachtwoord ingevoerd, verbinding staat open.

## MariaDB 

1. Commando `mysql -uroot -p` ingegeven gevolgd door wachtwoord, prompt komt overeen met gegeven.
2. Uit subshell gegaan.
3. Commando `mysql -uvagrant -p` ingegeven gevolgd door wachtwoord, prompt komt overeen met gegeven.
4. Commando `show databases;` ingevoerd, uitvoer komt overeen met gegeven:

```
+--------------------+      
| Database           |   
+--------------------+   
| information_schema |   
| vagrant            |   
+--------------------+   
```

## Apache & Drupal

1. Surfen naar localhost:8080 geeft volgende error: `ERR_CONNECTION_REFUSED`: localhost refused to connect.
2. Surfen naar localhost:8080/drupal geeft volgende error: `ERR_CONNECTION_REFUSED`: localhost refused to connect.

