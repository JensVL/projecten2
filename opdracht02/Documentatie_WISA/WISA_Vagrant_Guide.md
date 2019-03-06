# Testplan: Base box Vagrant (WISA)
*Author: Nathan Cammerman*


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

11. onder opsclag in de instellingen klikt u op het CD icoontje en selecteerd u de WindowsServer2016Iso.

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

25. Base WinRM Configuration: Start -> powershell -> 
secedit /export /cfg c:\secpol.cfg
(gc C:\secpol.cfg).replace(“PasswordComplexity = 1”, “PasswordComplexity = 0”) | Out-File C:\secpol.cfg
secedit /configure /db c:\windows\security\local.sdb /cfg c:\secpol.cfg /areas SECURITYPOLICY
rm -force c:\secpol.cfg -confirm:$false
winrm quickconfig -q
winrm set winrm/config/winrs @{MaxMemoryPerShellMB="512"}
winrm set winrm/config @{MaxTimeoutms="1800000"}
winrm set winrm/config/service @{AllowUnencrypted="true"}
winrm set winrm/config/service/auth @{Basic="true"}
sc config WinRM start= auto

26. herstart de virtuele machine en sluit hem daarna af.

### Vagrant eigen base box opstarten.

1. open cmd op je host computer. Dit doe je door eerst naar start te gaan. Dan typ je "cmd" in en klik je er op.

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