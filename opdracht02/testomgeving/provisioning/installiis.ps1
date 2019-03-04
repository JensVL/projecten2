Param(
  [string]$username = "wisa",
  [String]$password = "wisa",
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
