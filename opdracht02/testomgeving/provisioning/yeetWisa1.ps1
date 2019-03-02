#IIS
Param(
  [string]$username = "Administrator",
  [String]$password = "Admin2019",
  [string]$downloadpath = "C:\SetupMedia"
)

if($downloadpath.EndsWith("\")){
    $computerName.Remove($computerName.LastIndexOf("\"))
}

Install-WindowsFeature Web-Server, Web-Mgmt-Service -IncludeManagementTools > $null

mkdir $downloadpath

$file = $downloadpath + "\WebDeploy_amd64_en.msi"
(New-Object System.Net.WebClient).DownloadFile("https://download.microsoft.com/download/0/1/D/01DC28EA-638C-4A22-A57B-4CEF97755C6C/WebDeploy_amd64_en-US.msi", $file)
msiexec /i $file ADDLOCAL=DelegationScriptsFeature /qn /norestart LicenseAccepted="0"

$Acl = Get-Acl "C:\inetpub\wwwroot"
$Acl.SetAccessRule((New-Object  system.security.accesscontrol.filesystemaccessrule("LOCAL SERVICE","FullControl","Allow")))
Set-Acl "C:\inetpub\wwwroot" $Acl

[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.Web.Management")
[void][Microsoft.Web.Management.Server.ManagementAuthentication]::CreateUser($username, $password)
[void][Microsoft.Web.Management.Server.ManagementAuthorization]::Grant($username, "Default Web Site", $FALSE)

#SQL server
Param(
    #0 of 1 of $false of $true
    [boolean]$asp35 = $true,
    [boolean]$asp45 = $true
)

if($asp35){
    Install-WindowsFeature "Web-Asp-Net" > $null
}

if($asp45){
    Install-WindowsFeature "Web-Asp-Net45" > $null
}

#ASP.NET
Param(
  [string]$downloadpath = "C:\SetupMedia",
  [String]$instancename  = "SQLEXPRESS",
  [String]$rootpassword = "root",
  [int]$tcpportnr = 50000,
  [String]$dbname = "wisa",
  [String]$username = "Administrator",
  [String]$password = "Admin2019"
)

if($downloadpath.EndsWith("\")){
    $computerName.Remove($computerName.LastIndexOf("\"))
}

$instancename = $instancename.ToUpper()

if($tcpportnr -lt 49152 -or $tcpportnr -gt 65535){
    $tcpportnr = 50000
    echo "Portnumber has to be between 49152 and 65535. Currently set to 50000"
}

(New-Object System.Net.WebClient).DownloadFile("https://download.microsoft.com/download/5/E/9/5E9B18CC-8FD5-467E-B5BF-BADE39C51F73/SQLServer2017-SSEI-Expr.exe", "C:\sqlinstaller.exe")
Start-Process -FilePath C:\sqlinstaller.exe -ArgumentList "/action=download /quiet /enu /MediaPath=$downloadpath" -wait
Remove-Item C:\sqlinstaller.exe
Start-Process -FilePath $downloadpath\SQLEXPR_x64_ENU.exe -WorkingDirectory $downloadpath /q -wait

Start-Process -FilePath $downloadpath\SQLEXPR_x64_ENU\SETUP.EXE -ArgumentList "/Q /Action=install /IAcceptSQLServerLicenseTerms /FEATURES=SQL,Tools /TCPENABLED=1 /SECURITYMODE=`"SQL`" /SQLSYSADMINACCOUNTS=`"BUILTIN\Administrators`" /INSTANCENAME=$instancename /INSTANCEID=$instancename /SAPWD=$rootpassword" -wait

Import-Module -name 'C:\Program Files (x86)\Microsoft SQL Server\140\Tools\PowerShell\Modules\SQLPS'
Invoke-Sqlcmd -InputFile "C:\vagrant\files\configuresqlserver.sql" -ServerInstance ".\$instancename" -Variable "dbname=$dbname", "login=$username", "password=$password"

Set-ItemProperty -path "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQLServer\SuperSocketNetLib\Tcp\IPAll" -name TcpPort -value $tcpportnr
Restart-Service -Force "MSSQL`$$instancename" > $null
New-NetFirewallRule -DisplayName "Allow inbound sqlserver" -Direction Inbound -LocalPort $tcpportnr -Protocol TCP -Action Allow > $null
