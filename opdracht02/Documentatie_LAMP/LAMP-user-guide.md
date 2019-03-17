# Testplan: LAMP Stack
*Author(s): Yordi De Rijcke, Olivier De Vriese*

## Configureerbare componenten (vagrant-hosts.yml)
* name: Naam van de VM
* box: Naam van de gebruikte base box 
* ip: IP-adres dat gebruikt wordt om te communiceren met de VM
* os: OS van de base box
* gui:   
    * false: Headless VM 
    * true: Normal VM 
* memory: hoeveelheid RAM in MB uitgedrukt.
* cpus: aantal toegewezen processors
* linux: 
    * rootPassword: "wachtwoord voor de linux root user"
    * vagrantPassword: "wachtwoord voor de linux vagrant user"
* mariaDB: 
    * rootPassword: "wachtwoord voor de mariaDB root user" 
    * dbName: "naam van de database voor de webapplicatie"
    * userName: "naam van de gebruiker voor de bovenstaande DB"
    * password: "wachtwoord voor de bovenstaande gebruiker"
* forwarded_ports: 
    * guest: poortnummer van in de VM
    * host: poortnummer van op de host

## Website hosten op Apache
1. Maak een (S)FTP-verbinding met de VM (poort 2222)
2. Plaats de website in de directory /var/www/html
3. Verander de eigenaar van de website naar apache met het commando: "sudo chown -R apache:apache /var/www/html"

## Toegang krijgen tot de MySQL Databank
1. Maak een SSH-verbinding met de VM (poort 2222)
2. Verkrijg toegang tot MySQL via het commando "mysql -uvagrant -p\<wachtwoord uit vagrant-hosts.yml\>"
3. Verkrijg toegang tot de MySQL database via het commando "USE \<dbName uit vagrant-hosts.yml\>"