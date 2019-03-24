# Testplan Opdracht 2: LAMP-Stack

Auteur(s) testplan: Yordi De Rijcke & Olivier De Vriese

## Vagrant & Linux
1. Start de VM met het commando "vagrant up".
2. Maak een SSH verbinding met de VM via het commando "vagrant ssh".
3. Je zou nu volgende prompt moeten zien "[vagrant@LAMP-srv ~]$".
4. Geef het commando "su" in met het wachtwoord vanuit vagrant-hosts.yml.  
5. Je zou volgende prompt moeten zien "[root@LAMP-srv vagrant]#".
6. Beëindig de SSH-sessie.
7. Test het vagrant user wachtwoord van de VM door een SSH verbinding te starten (bv met PuTTY).   
Gebruik als hostname "vagrant@localhost" en poort "2222".
8. De verbinding zou moeten slagen met het opgegegeven wachtwoord uit vagrant-hosts.yml
9. Houd deze SSH verbinding open voor de rest van het testplan

## MariaDB 
1. Test het MariaDB root wachtwoord met het commando "mysql -uroot -p\<wachtwoord uit vagrant-hosts.yml\>"
2. Je zou nu de volgende prompt moeten zien "MariaDB [(none)]>"
3. Typ "exit" om uit de subshell te gaan.
4. Test nu de MariaDB vagrant user met het commando "mysql -uvagrant -p\<wachtwoord uit vagrant-hosts.yml\>"
5. Je zou nu dezelfde prompt moeten zien als bij stap 2
6. Typ in deze subshell het commando "show databases;"
7. Volgende uitvoer is verwacht:   
```
+--------------------+      
| Database           |   
+--------------------+   
| information_schema |   
| vagrant            |   
+--------------------+   
```

## Apache & Drupal
1. Controleer of de webserver werkt door te surfen naar "192.168.248.11"
2. Je zou nu de startpagina van Apache moeten zien
3. Controleer of Drupal werkt door te surfen naar "192.168.248.11/drupal"
4. Je zou nu de startpagina van Drupal moeten zien
