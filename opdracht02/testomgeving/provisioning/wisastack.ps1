Param(
  [string]$downloadpath = "C:\SetupMedia",
  [String]$instancename  = "SQLEXPRESS",
  [String]$rootpassword = "root",
  [int]$tcpportnr = 50000,
  [String]$dbname = "vagrant",
  [String]$sqlusername = "vagrant",
  [String]$sqlpassword = "vagrant",

  [string]$iisusername = "vagrant",
  [String]$iispassword = "vagrant",

  [boolean]$asp35 = $false,
  [boolean]$asp45 = $false,
  [boolean]$dotnetcore21 = $false,
  [boolean]$dotnetcore22 = $true,

  [boolean]$blogdemo = $true
)

if($downloadpath.EndsWith("\")){
    $computerName.Remove($computerName.LastIndexOf("\"))
}

if(!(Test-Path $downloadpath)){
    mkdir $downloadpath
}

# Install + configure IIS
$serviceWebserver = Get-WindowsFeature Web-Server
$servicesWebManagement = Get-WindowsFeature Web-Mgmt-Service
if(!($serviceWebserver).Installed -or !($servicesWebManagement).Installed){
    Write-Host('Downloading IIS...')
    Install-WindowsFeature Web-Server, Web-Mgmt-Service -IncludeManagementTools > $null
}else{
    Write-Host('IIS already installed(skipping)')
}


$file = $downloadpath + "\WebDeploy_amd64_en.msi"
if(!(Test-Path $file)){
    Write-Host('Installing Webdeploy...')
    (New-Object System.Net.WebClient).DownloadFile("https://download.microsoft.com/download/0/1/D/01DC28EA-638C-4A22-A57B-4CEF97755C6C/WebDeploy_amd64_en-US.msi", $file)
    msiexec /i $file ADDLOCAL=DelegationScriptsFeature /qn /norestart LicenseAccepted="0"
}

$Acl = Get-Acl "C:\inetpub\wwwroot"
$Acl.SetAccessRule((New-Object  system.security.accesscontrol.filesystemaccessrule("LOCAL SERVICE","FullControl","Allow")))
Set-Acl "C:\inetpub\wwwroot" $Acl

Try{
    Write-Host('User vagrant already exists(skipping)')
    [void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.Web.Management")
    [void][Microsoft.Web.Management.Server.ManagementAuthentication]::CreateUser($iisusername, $iispassword)
    [void][Microsoft.Web.Management.Server.ManagementAuthorization]::Grant($iisusername, "Default Web Site", $FALSE)
}
Catch [System.Management.Automation.RuntimeException]{
    Write-Host('User vagrant already exists(skipping)')
}

# Install ASP.NET
$serviceAsp35 = Get-WindowsFeature Web-Asp-Net
if($asp35){
    if(!($serviceAsp35).Installed){
        Write-Host('Installing .NET Framework support for 3.5 and lower ...')
        Install-WindowsFeature Web-Asp-Net > $null
    }else{
        Write-Host('.NET 3.5 Framework already installed(skipping)')
    }
   
}

$serviceAsp45 = Get-WindowsFeature Web-Asp-Net45
if($asp45){
    if(!($serviceAsp45).Installed){
        Write-Host('Installing .NET Framework support for 4.5 and higher ...')
        Install-WindowsFeature Web-Asp-Net45 > $null
    }else{
        Write-Host('.NET 4.5 Framework already installed(skipping)')
    }
    
}

if($dotnetcore21){
    if(!(Test-Path "C:\Program Files\dotnet")){
        # download .NET core 2.1
        Write-Host('Downloading .NET Core 2.1 installer ...')
        $file = $downloadpath + "\dotnet-hosting-2.1.9-win.exe"
        Invoke-WebRequest https://download.visualstudio.microsoft.com/download/pr/dc431217-1692-4db1-9e8b-3512c9788292/3070b595006fadcac1ce3b02aff5fadf/dotnet-hosting-2.1.9-win.exe -OutFile $file

        # run installer
        Write-Host('Running the .NET Core 2.1 installer ...')
        Start-Process -FilePath $file -ArgumentList /S, /v, /qn -Wait 

        # restart web server
        net stop was /y
        net start w3svc
    } else {
        Write-Host('.NET Core 2.1 already installed(skipping)')
    }
}

if($dotnetcore22){
    # download .NET core 2.2
    $DotNETCoreUpdatesPath = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Updates\.NET Core" 
    $DotNetCoreItems = Get-Item -ErrorAction Stop -Path $DotNETCoreUpdatesPath 
    $Installed = $False 
    $DotNetCoreItems.GetSubKeyNames() | where { $_ -Match "Microsoft .NET Core.*Windows Server Hosting" } | ForEach-Object { 
        $Installed = $True 
    } 

    if(!($Installed)) { 
        Write-Host "Can not find ASP.NET Core installed on the host" 
    
        $file = $downloadpath + "\dotnet-hosting-2.2.3-win.exe"
        if(!(Test-Path $file)) {
            Write-Host('Downloading .NET Core 2.2 installer ...')
            # Invoke-WebRequest https://download.visualstudio.microsoft.com/download/pr/a46ea5ce-a13f-47ff-8728-46cb92eb7ae3/1834ef35031f8ab84312bcc0eceb12af/dotnet-hosting-2.2.3-win.exe -OutFile $file
        
            # Start-Sleep -s 15
        }
        # run installer
        Write-Host('Running the .NET Core 2.2 installer ...')
        Start-Process -FilePath $file -ArgumentList /S, /v, /qn -Wait 


        # restart web server
        Write-Host('Restarting Web Services ...')
        net stop was /y
        net start w3svc
        
    } else {
        Write-Host('.NET Core 2.2 already installed(skipping)')
    }
}



# Install + configure SQL Server
if (Test-Path "HKLM:\Software\Microsoft\Microsoft SQL Server\Instance Names\SQL") {
    Write-Host('SQL Server already installed(skipping)')
} else {
    Write-Host('Installing SQL Server...')
    $instancename = $instancename.ToUpper()

    if($tcpportnr -lt 49152 -or $tcpportnr -gt 65535){
        $tcpportnr = 50000
        echo "Portnumber has to be between 49152 and 65535. Default = 50000"
    }

    (New-Object System.Net.WebClient).DownloadFile("https://download.microsoft.com/download/5/E/9/5E9B18CC-8FD5-467E-B5BF-BADE39C51F73/SQLServer2017-SSEI-Expr.exe", "C:\sqlinstaller.exe")
    Start-Process -FilePath C:\sqlinstaller.exe -ArgumentList "/action=download /quiet /enu /MediaPath=$downloadpath" -wait
    Remove-Item C:\sqlinstaller.exe
    Start-Process -FilePath $downloadpath\SQLEXPR_x64_ENU.exe -WorkingDirectory $downloadpath /q -wait

    Start-Process -FilePath $downloadpath\SQLEXPR_x64_ENU\SETUP.EXE -ArgumentList "/Q /Action=install /IAcceptSQLServerLicenseTerms /FEATURES=SQL,Tools /TCPENABLED=1 /SECURITYMODE=`"SQL`" /SQLSYSADMINACCOUNTS=`"BUILTIN\Administrators`" /INSTANCENAME=$instancename /INSTANCEID=$instancename /SAPWD=$rootpassword" -wait

    Import-Module -name 'C:\Program Files (x86)\Microsoft SQL Server\140\Tools\PowerShell\Modules\SQLPS'
    Invoke-Sqlcmd -InputFile "C:\vagrant\provisioning\configuresqlserver.sql" -ServerInstance ".\$instancename" -Variable "dbname=$dbname", "login=$sqlusername", "password=$sqlpassword"

    Set-ItemProperty -path "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQLServer\SuperSocketNetLib\Tcp\IPAll" -name TcpPort -value $tcpportnr
    Restart-Service -Force "MSSQL`$$instancename" > $null
    New-NetFirewallRule -DisplayName "Allow inbound sqlserver" -Direction Inbound -LocalPort $tcpportnr -Protocol TCP -Action Allow > $null
}


# Deploy blog demo
if($blogdemo){
    $publocation = "C:\inetpub\wwwroot\"
    $directoryInfo = Get-ChildItem $publocation | Measure-Object
    if(!($directoryInfo.count -eq 0)){
        Get-ChildItem -Path $publocation -Include * -File -Recurse | foreach { $_.Delete()}
        Write-Host('Deploying Blog Demo ...')
        $msdeploy = "C:\Program Files\IIS\Microsoft Web Deploy V3\msdeploy.exe"
        & $msdeploy -verb:sync -source:package="C:\vagrant\provisioning\Blogifierpackage\App.zip" -dest:auto >$null
    }
}


