# Testplan: Base box Vagrant (WISA)
*Author: Nathan Cammerman, Matthias Van De Velde*

## Configurable components (vagrant-hosts.yml
* name: Name of the base box instance
* box: Base box used for the instance
* ip: Ip address that uses a host-only adapter to communicate with host
* os: Operating system of the base box
* gui: Wether to start the instance in headless(false) or normal mode(true) 
* winrm-user: windows username to communicate through winrm
* winrm-pw: password used to validate winrm-user

* iis:
    * username: Username of the iis-user. By default "vagrant"
    * password: Password of the iis-user. By default "vagrant"
    * downloadpath: Where to store temporary iis installation files. By Default "C:\SetupMedia"
* asp:
    * asp35: Install ASP.NET 3.5 (and lower) ($true / $false)
    * asp45: Install ASP.NET 4.5 (and higher) ($true / $false)
* sql:
    * downloadpath: Where to store temporary sql installation files.
    * instancename: SQL-Server instance name. By default "SQLEXPRESS"
    * rootpassword: Password of root user. By default "root"
    * tcpportnr: TCP-port used to connect to the database (between 49152 and 65535)
    * dbname: Database name. By default "vagrant"
    * username: Username of development account. By default "vagrant"
    * password: Password to validate sql username. By default "vagrant"
* forwarded_ports: Forwarded ports for RDP connection (guest and host are both obligatory)

## Connect to SQL database
1. Open SQL Server Management Studio on your host machine
2. Use the following table to confgure the connection

| Item | Value |
| :--- | :--- |
| Server name | [ip-address,port-number] |
| Authentication | "SQL Server Authentication" |
| Login | [username] |
| Password | [password] | 


## Deploy application using Visual Studio
1. Right click on the application in the solution explorer and select the “Publish" option
2. Create new publishing profile: “IIS, FTP, etc"
3. Use the following table to configure the connection

| Item | Value |
| :--- | :--- |
| Publish method | "Web Deploy" |
| Server | [ip address of server] |
| Site name | "Default Web Site" |
| User name | [iis username] |
| Password | [iis password] |
| Destination URL | [leave empty] |

4. Click on Validate Connection
5. If the connection was successfull, click save and then publish



## Eigen Base box gebruiken.

### Base box maken:
*In dit voorbeeld maken we gebruik van virtualbox en gaan we ervan uit dat U de windowsServer2016 iso heeft*.

1. Open virtual box.

2. Klik op nieuw.

3. Geef het een naam, locatie, laat type op Microsoft Windows staan en selecteer de versie "Other Windows (64-bit)".

4. Geef de virtuele machine een geheugengrootte van minimum 2 Gigabyte indien mogelijk.

5. Kies optie: "Maak nieuwe virtuele hade schijf aan"

6. Kies optie: "VDI" 

7. Kies optie: "dynamisch gealloceerd"

8. Kies uw opslaggrootte. Aanbevolen -> 100gb.

9. Ga naar instellingen van uw virtuele machine.

10. Onder netwerken mag er maar 1 adapter zijn en deze moet van het type "NAT" zijn.

11. Onder opsclag in de instellingen klikt u op het CD icoontje en selecteerd u de WindowsServer2016Iso.

12. (optioneel) Onder beeldscherm kan U het videogeheugen maximaal zetten om betere prestaties te bekomen.

13. (optioneel) Onder Systeem en dan processor kan U dit ook verhogen om betere prestaties te bekomen.

14. Start de virtuele machine door er op te klikken.

15. Kies voor de opties English, English(Belgium), Belgium period.

16. Kies voor desktop experience.

17. Kies voor custom installation. Hierbij maak je een nieuwe partitie aan door op new te klikken. Ga dan verder.

18. Na het heropstarten verwijder je de iso onder apparaten.

19. Er wordt gevraagd naar een Naam en paswoord. Kies hiervoor een veilig paswoord(in ons geval gebruiken we Admin2019). Als gebruikersnaam kies je het beste "Administrator".

20. Log in.

21. UAC afzetten: start -> Control panel -> System Security -> onder Action center kies **Change User Account Control settings** -> doe de sleepbalk helemaal naar beneden tot **Never notify** ->ok->herstart de machine.

22. Disable complex passwords afzetten: Start -> Open "Administrative Tool" -> select "Local Security Policy" -> vervang paswoord "Must Meet Complex Requirements option" naar "Disabled".

23. Shutdown Event Tracker uitzetten: start -> start run applicatie -> geef "gpedit.msc" in -> klik op "Computer Configuration> Administrative Templates> System". Scroll naar beneden tot je "Display shutdown event tracker" ziet -> klik erop -> selecteer Disable (links bovenaan).

24. "Server Manager" starting at login (for non-Core) afzetten: Start -> powershell -> New-ItemProperty -Path HKLM:Software\Microsoft\Windows\CurrentVersion\policies\system -Name EnableLUA -PropertyType DWord -Value 0 -Force -> enter.

25. Base WinRM Configuration: Start -> powershell -> secedit /export /cfg c:\secpol.cfg
(gc C:\secpol.cfg).replace(“PasswordComplexity = 1”, “PasswordComplexity = 0”) | Out-File C:\secpol.cfg
secedit /configure /db c:\windows\security\local.sdb /cfg c:\secpol.cfg /areas SECURITYPOLICY
rm -force c:\secpol.cfg -confirm:$false
winrm quickconfig -q
winrm set winrm/config/winrs @{MaxMemoryPerShellMB="512"}
winrm set winrm/config @{MaxTimeoutms="1800000"}
winrm set winrm/config/service @{AllowUnencrypted="true"}
winrm set winrm/config/service/auth @{Basic="true"}
sc config WinRM start= auto

26. creatie shared folder: Server manager dashboard -> Tools —> klik op "Computer Management" -> expand "System Tools" —> expand "Shared Folders" —> klik op "Shares" —> Selecteer "New Share" -> Wizard -> next -> typ het pad waar je de "shared folder" wilt of klik "browse" en maak een nieuwe folder met "Make new folder" (en kies dan dit pad) -> next -> naam + descriptie invullen -> selecteer gewenste optie -> finish

27. Toestaan Remote Desktop: open server manager -> local Server -> klik op de "Disabled" tekst -> vanuit de property window, selecteer "Sta externe verbindingen met deze computer toe" -> klik "ok" -> Er komt een waarschuwings window  -> klik ok.

28. Herstart de virtuele machine en sluit hem daarna af.

### Vagrant eigen base box opstarten.

1. Open cmd op je host computer. Dit doe je door eerst naar start te gaan. Dan typ je "cmd" in en klik je er op.

2. Navigeer je naar de gewenste directory door het commando "dir" gevolgd door het gewenste pad. gelieve een directory te kiezen die gemakkelijk navigerbaar is.

3. Nu gaan we van onze virtuele machine een base box maken. Dit doen we door in de cmd het volgend command in te geven: vagrant package --base *naam van uw Virtuele machine*.
Dit maakt een package.box file. Deze stap kan lang duren.

4. Vervolgens dient U het volgend e commando in te geven om de ze base box toe te voegen: vagrant box add --name *pad naar package.box file*. Deze stap kan lang duren.

5. Vervolgens willen we de gewenste base box selecteren. Dit doen we door het commando: vagrant init *naam van de base box*

6. Hierna willen we de base box opstarten dit doen we door het commando: vagrant up

7. Nu willen we ons inloggen in onze base box. Dit doen we met het commando: vagrant ssh

8. Vervolgens start de base box zich op.

### Vagrant base box opstarten van Vagrant server.

1. open cmd op je host computer. Dit doe je door eerst naar start te gaan. Dan typ je "cmd" in en klik je er op.

2. Vervolgens willen we de gewenste base box selecteren van de vagrant server. Dit doen we door het commando: vagrant init *naam van de base box op de vagrant server*

3. Vervolgens willen we de base box opstarten dit doen we door het commando: vagrant up

4. Vervolgens willen we inloggen in onze base box. Dit doen we met het commando: vagrant ssh

5. Vervolgens start de base box zich op.

# Connect to the databases

1. Open Microsoft SQL Server Management Studio with following parameters:

```
Server name: 192.168.248.10,50000
Authentication: SQL Server Authentication
Login: vagrant
Password: vagrant
```

# Deploying webapplicationserver

1. Open the project using the PROJECT_NAME.sln file (Located in the DOTNETproject-map)

2. Right click on the application in the solution explorer and select the “Publish” option

3. Create new publishing profile: “IIS, FTP, etc”

4. Enter following settings:

```
Publish method: Web Deploy
Server: 192.168.248.10
Site name: Default Web Site
User name: vagrant
Password: vagrant
Destination URL: http://192.168.248.10/Bierhalle
Validate connection and press “next”
```
5. Choose configuration option "Debug" and tik boxes "Remove additional files at destination" and "Exclude files from the App_Data folder" on. 

6. Press Save and Publish the Application.

7. To test, you can surf on your host-machine to 192.168.248.10 and the application should be running

8. To verify the Database functionality: try to add, edit and delete information and reload the page after each operation.