# Testplan: Base box Vagrant (WISA)
*Author: Nathan Cammerman, Matthias Van De Velde*

## Configurable components (vagrant-hosts.yml
* !Disclaimer! Every single key-value pair in the YAML file needs to be filled in!
* name: Name of the base box instance
* box: Base box used for the instance
* ip: Ip address that uses a host-only adapter to communicate with host
* os: Operating system of the base box
* gui: Wether to start the instance in headless(false) or normal mode(true) 
* memory: The memory size you want to give to the base box.
* cpus: The amount of cores you want to use for the base box
* downloadpath: Where to store all files. By default "C:\\SetupMedia"
* blogdemo: If you want to use the demo application ($true/$false).

* iis:
    * username: Username of the iis-user. By default "vagrant" 
    * password: Password of the iis-user. By default "vagrant"
* asp:
    * asp35: Install ASP.NET 3.5 (and lower) ($true / $false)
    * asp45: Install ASP.NET 4.5 (and higher) ($true / $false)
    * dotnetcore21: Install .NET Core 2.1 ($true / $false)
    * dotnetcore22: Install .NET Core 2.2 ($true / $false)
* sql:
    * instancename: SQL-Server instance name. By default "SQLEXPRESS" (specified in wisastack.ps1)
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

## Deploying Blogdemo application for testing, using Visual Studio
1. Change blogdemo to $true in the yaml host file.
2. Open the blogifier-project solution.
3. Change the settings according to your needs. 
- Ex: appsettings.json file for the database connection.
- "DemoMode": false
- "SeedData": false
- "SendGridApiKey": "YOUR-SENDGRID-API-KEY"
- "ConnString": "Your_Connectiostring"
4. Follow the same instructions as "Deploy application using Visual Studio" to deploy it. 

## Deploy own application using Visual Studio
1. Go to the file yaml host file and change the value of demoblog to $false.
2. Follow the same instructions as "Deploy application using Visual Studio" to deploy your own application and change the settings according to your needs.