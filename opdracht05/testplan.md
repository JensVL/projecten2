# Testplan opdracht 5

Auteur(s) testplan: Olivier De Vriese, Yordi De Rijcke

## Provisioning
1. Gebruik ```vagrant up``` om de VMs te starten

## Test Applicatieserver
1. Gebruik ```vagrant ssh Applicatieserver```
2. Run ```createLedenDBBackup.sh```
3. Je zou hier geen fouten mogen bij krijgen
4. Gebruik ```vagrant ssh Backupserver```
5. Controleer of alle backups te vinden zijn op Backupserver (/applicatieserver_backups/LedenDB)

## Test Backupserver
1. Run ```syncLesmateriaal.sh <file1> [file2] ...```
2. Je zou hier geen fouten mogen bij krijgen
3. Gebruik ```vagrant ssh Applicatieserver```
4. Controleer of al het lesmateriaal te vinden is in de correcte plaats op applicatieserver (/lesmateriaal/)



