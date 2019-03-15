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
Write-Host('Downloading IIS...')
Install-WindowsFeature Web-Server, Web-Mgmt-Service -IncludeManagementTools > $null


$file = $downloadpath + "\WebDeploy_amd64_en.msi"
if(!(Test-Path $file)){
    Write-Host('Installing IIS...')
    (New-Object System.Net.WebClient).DownloadFile("https://download.microsoft.com/download/0/1/D/01DC28EA-638C-4A22-A57B-4CEF97755C6C/WebDeploy_amd64_en-US.msi", $file)
    msiexec /i $file ADDLOCAL=DelegationScriptsFeature /qn /norestart LicenseAccepted="0"
}

$Acl = Get-Acl "C:\inetpub\wwwroot"
$Acl.SetAccessRule((New-Object  system.security.accesscontrol.filesystemaccessrule("LOCAL SERVICE","FullControl","Allow")))
Set-Acl "C:\inetpub\wwwroot" $Acl

Try{
    [void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.Web.Management")
    [void][Microsoft.Web.Management.Server.ManagementAuthentication]::CreateUser($iisusername, $iispassword)
    [void][Microsoft.Web.Management.Server.ManagementAuthorization]::Grant($iisusername, "Default Web Site", $FALSE)
}
Catch [System.Management.Automation.RuntimeException]{

}

# Install ASP.NET
if($asp35){
    Write-Host('Installing .NET Framework support for 3.5 and lower ...')
    Install-WindowsFeature "Web-Asp-Net" > $null
}

if($asp45){
    Write-Host('Installing .NET Framework support for 4.5 and higher ...')
    Install-WindowsFeature "Web-Asp-Net45" > $null
}

if($dotnetcore21){
    if(!(Test-Path "C:\Program Files\dotnet")){
        # download .NET core 2.1
        Write-Host('Downloading .NET Core 2.1 installer ...')
        $file = $downloadpath + "\dotnet-hosting-2.1.9-win.exe"
        Invoke-WebRequest https://download.visualstudio.microsoft.com/download/pr/dc431217-1692-4db1-9e8b-3512c9788292/3070b595006fadcac1ce3b02aff5fadf/dotnet-hosting-2.1.9-win.exe -OutFile $file

        # run installer
        .\dotnet-hosting-2.1.9-win.exe /install

        # restart web server
        net stop was /y
        net start w3svc
    }
}

if($dotnetcore22){
    # download .NET core 2.2
    if(!(Test-Path "C:\Program Files\dotnet")){
        Write-Host('Downloading .NET Core 2.2 installer ...')
        $file = $downloadpath + "\dotnet-hosting-2.2.3-win.exe"
        Invoke-WebRequest https://download.visualstudio.microsoft.com/download/pr/a46ea5ce-a13f-47ff-8728-46cb92eb7ae3/1834ef35031f8ab84312bcc0eceb12af/dotnet-hosting-2.2.3-win.exe -OutFile $file

        # run installer
        .\dotnet-hosting-2.2.3-win.exe /install

        # restart web server
        net stop was /y
        net start w3svc
    }
}



# Install + configure SQL Server
# Write-Host('Installing SQL Server...')
# $instancename = $instancename.ToUpper()

# if($tcpportnr -lt 49152 -or $tcpportnr -gt 65535){
#     $tcpportnr = 50000
#     echo "Portnumber has to be between 49152 and 65535. Default = 50000"
# }

# (New-Object System.Net.WebClient).DownloadFile("https://download.microsoft.com/download/5/E/9/5E9B18CC-8FD5-467E-B5BF-BADE39C51F73/SQLServer2017-SSEI-Expr.exe", "C:\sqlinstaller.exe")
# Start-Process -FilePath C:\sqlinstaller.exe -ArgumentList "/action=download /quiet /enu /MediaPath=$downloadpath" -wait
# Remove-Item C:\sqlinstaller.exe
# Start-Process -FilePath $downloadpath\SQLEXPR_x64_ENU.exe -WorkingDirectory $downloadpath /q -wait

# Start-Process -FilePath $downloadpath\SQLEXPR_x64_ENU\SETUP.EXE -ArgumentList "/Q /Action=install /IAcceptSQLServerLicenseTerms /FEATURES=SQL,Tools /TCPENABLED=1 /SECURITYMODE=`"SQL`" /SQLSYSADMINACCOUNTS=`"BUILTIN\Administrators`" /INSTANCENAME=$instancename /INSTANCEID=$instancename /SAPWD=$rootpassword" -wait

# Import-Module -name 'C:\Program Files (x86)\Microsoft SQL Server\140\Tools\PowerShell\Modules\SQLPS'
# Invoke-Sqlcmd -InputFile "C:\vagrant\provisioning\configuresqlserver.sql" -ServerInstance ".\$instancename" -Variable "dbname=$dbname", "login=$sqlusername", "password=$sqlpassword"

# Set-ItemProperty -path "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQLServer\SuperSocketNetLib\Tcp\IPAll" -name TcpPort -value $tcpportnr
# Restart-Service -Force "MSSQL`$$instancename" > $null
# New-NetFirewallRule -DisplayName "Allow inbound sqlserver" -Direction Inbound -LocalPort $tcpportnr -Protocol TCP -Action Allow > $null



if($blogdemo){
    [string]$sourceDirectory  = "C:\vagrant\provisioning\Blogifier\*"
    [string]$destinationDirectory = "C:\inetpub\wwwroot\"
    Copy-item -Force -Recurse -Verbose $sourceDirectory -Destination $destinationDirectory
}


# if($blogdemo){
#     # Deploy .net app
#     Write-Host('Deploying App...')
#     [string]$username="vagrant"
#     [string]$downloadlink="https://github.com/rxtur/BlogEngine.NET/releases/download/v3.3.6.0/3360.zip"
#     [string]$downloadlinkpath="C:\Users\" + $username + "\Documents\aspdotnetapp.zip"
#     [string]$outpath="C:\inetpub\wwwroot\"

#     ## Downloading from link
#     Write-Host("Downloading zip")
#     [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
#     Invoke-WebRequest $downloadlink -OutFile $downloadlinkpath

#     ## Delete wwwroot files and folders
#     Write-Host("clearing wwwroot")
#     Get-ChildItem -Path C:\inetpub\wwwroot -Include *.* -File -Recurse | foreach {$_.Delete()}

#     ##  Unpacking download
#     Write-Host("Unpacking zip")
#     Add-Type -AssemblyName System.IO.Compression.FileSystem
#     [System.IO.Compression.ZipFile]::ExtractToDirectory($downloadlinkpath, $outpath)
#     Write-Host("Zip unpacked")

#     ## Setting permissions
#     $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("IIS_IUSRS", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")

#     $AclAppData = Get-Acl "C:\inetpub\wwwroot\App_Data"
#     $AclCustom = Get-Acl "C:\inetpub\wwwroot\Custom"

#     $AclAppData.AddAccessRule($accessRule)
#     $AclCustom.AddAccessRule($accessRule)

#     Set-Acl -Path "C:\inetpub\wwwroot\App_Data" -ACLObject $AclAppData
#     Set-Acl -Path "C:\inetpub\wwwroot\Custom" -ACLObject $AclCustom
# }
