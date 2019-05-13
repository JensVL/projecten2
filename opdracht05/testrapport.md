# Testrapport taak 5: Backupserver & Applicatieserver

## Test 1

Uitvoerder(s) test: Jens Van Liefferinge
Uitgevoerd op: 13/5/2019
Github commit:  ddaf09

## Provisioning
1. VMs opgestart met gebruik van ```vagrant up```.

## Test Applicatieserver
1. SSH verbinding applicatieserver opgezet met behulp van ```vagrant ssh Applicatieserver```.
2. ```createLedenDBBackup.sh``` uitgevoerd.
3. Geen fouten getoond.
4. SSH verbinding backupserver opgezet met behulp van ```vagrant ssh Backupserver```.
5. Alle backups zijn te vinden op Backupserver (/applicatieserver_backups/LedenDB).

## Test Backupserver
1. ```syncLesmateriaal.sh <file1> [file2] ...``` uitgevoerd.
2. Geen fouten getoond.
3. SSH verbinding applicaieserver opgezet met behulp van ```vagrant ssh Applicatieserver```.
4. Al het lesmateriaal is te vinden op de correcte plaats op applicatieserver (/lesmateriaal/).