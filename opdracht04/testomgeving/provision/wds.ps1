#Bootfile moet eerst gemaakt zijn voordat dit uitgevoerd wordt want ze gebruiken deze WIM file.
## Install WDS
### TODO: Boot image, installationgroup name en pad instellen

Write-Host("Installing WDS...")
    try{
        Write-Host "Imports the Windows Deployment Services PowerShell module"
        Install-WindowsFeature wds-deployment -includemanagementtools
        Write-Host "- Windows Deployment Services PowerShell module imported"
    catch
         {
            Write-Warning "- Could not import the Windows Deployment Services PowerShell module from first location"
            Write-Warning "- Trying to Import the WDS PowerShell module again"
            try
			{
                Write-Host "Imports the Windows Deployment Services PowerShell module"
				Install-WindowsFeature wds-deployment -includemanagementtools
				 Write-Host "- Windows Deployment Services PowerShell module imported"
			}
			catch
			{
				Write-Warning "- Could not import the Windows Deployment Services PowerShell module"
				Break
			}
        }
}

Write-Host("Initializing WDS Server...")
    try{
        $wdsUtilResults = wdsutil /initialize-server /remInst:"E:\remInstall"
        $wdsUtilResults | select -last 1
    catch
         {
            Write-Warning "- Could not initialize the Windows Deployment Services PowerShell module"
        }
}

Write-Host("Adding Boot image WDS Server...")
    try{
        Import-WdsBootImage -Path "D:\sources\boot.wim" ###Boot image moeten we nog krijgen.
    catch
         {
            Write-Warning "- Could not initialize the Windows Deployment Services PowerShell module"
        }
}

Write-Host("Importing the WDS Install Image...")
    try{
        New-WdsInstallImageGroup -Name "desktops" ### Je kan deze noemen hoe je wil
        Get-WindowsImage -imagePath "D:\sources\install.wim" | select Imagename ### Een WIM op een install media kan meerdere images hebben. We gebruiken de Get-WindowsImage command om de images op te lijsten.
        $imageName = 'Windows 10 Pro' ### Kies de naam van de geselecteerde Image
        Import-WdsInstallImage -ImageGroup "desktops" -Path "D:\sources\install.wim" -ImageName $imageName

    catch
         {
            Write-Warning "- Could not initialize the Windows Deployment Services PowerShell module"
        }
}



### install MDT
### TODO if clausule errond

Write-Host("Installing MDT...")
#Input Parameters
param (
    [Parameter(Mandatory = $true)]
    [string] $ServiceAccountPassword,

    [Parameter(Mandatory = $true)]
    [ValidateScript( {Test-Path $_})]
    [string]$DeploymentShareDrive,

    [Parameter(Mandatory = $false)]
    [switch] $Office365,

    [Parameter(Mandatory = $false)]
    [switch] $Applications
)

$ErrorActionPreference = "Stop"

$DeploymentShareDrive = $DeploymentShareDrive.TrimEnd("\")

#Get Installers
Write-Host "Downloading MDT 8450"
$params = @{
    Source      = "https://download.microsoft.com/download/3/3/9/339BE62D-B4B8-4956-B58D-73C4685FC492/MicrosoftDeploymentToolkit_x64.msi"
    Destination = "$PSScriptRoot\mdt_install.msi"
    ErrorAction = "Stop"
}
Start-BitsTransfer @params

Write-Host "Downloading ADK 1803"
$params = @{
    Source      = "http://download.microsoft.com/download/6/8/9/689E62E5-C50F-407B-9C3C-B7F00F8C93C0/adk/adksetup.exe"
    Destination = "$PSScriptRoot\adk_setup.exe"
    ErrorAction = "Stop"
}
Start-BitsTransfer @params

#Run Installs
Write-Host "Installing MDT"
Start-Process msiexec.exe -Wait -ArgumentList "/i ""$PSScriptRoot\mdt_install.msi"" /qn" -ErrorAction Stop

Write-Host "Installing ADK"
$params = @{
    FilePath     = "$PSScriptRoot\adk_setup.exe"
    ArgumentList = "/quiet /features OptionId.DeploymentTools OptionId.WindowsPreinstallationEnvironment"
    ErrorAction  = "Stop"
}
Start-Process @params -Wait

#Import MDT Module
Write-Host "Importing MDT Module"
Import-Module "C:\Program Files\Microsoft Deployment Toolkit\bin\MicrosoftDeploymentToolkit.psd1" -ErrorAction Stop

#Create Deployment Share
Write-Host "Create Deployment Share"
$localUser = "svc_mdt" ###andere naam localuser? Dit is normaal default
$localUserPasswordSecure = ConvertTo-SecureString $ServiceAccountPassword -AsPlainText -Force -ErrorAction Stop
New-LocalUser -AccountNeverExpires -Name $localUser -Password $localUserPasswordSecure -PasswordNeverExpires -ErrorAction Stop
New-Item -Path "$DeploymentShareDrive\DeploymentShare" -ItemType directory -ErrorAction Stop ### eventueel andere pad maar dit lijkt goed.
New-SmbShare -Name "DeploymentShare$" -Path "$DeploymentShareDrive\DeploymentShare" -ReadAccess "$env:COMPUTERNAME\$localUser" -ErrorAction Stop ###Als je het hierboven aanpast dan hier natuurlijk ook

$params = @{ ### kan je eigenlijk volledig aanpassen indien gewenst
    Name        = "DS001"
    PSProvider  = "MDTProvider"
    Root        = "$DeploymentShareDrive\DeploymentShare"
    Description = "MDT Deployment Share"
    NetworkPath = "\\$env:COMPUTERNAME\DeploymentShare$"
    ErrorAction = "Stop"
}
New-PSDrive @params -Verbose | add-MDTPersistentDrive -Verbose

#Import WIM
Write-Host "Checking for wim files"
$Wims = Get-ChildItem $PSScriptRoot -Filter "*.wim" | Select-Object -ExpandProperty FullName ### Ze gaan er denk ik van uit dat u .wim file in een niveau boven U root staat
if (!$Wims) {
    Write-Host "No wim files found"
}

if ($Wims) {
    foreach($Wim in $Wims){
    $WimName = Split-Path $Wim -Leaf
    $WimName = $WimName.TrimEnd(".wim")
    Write-Host "$WimName found - will import"
    $params = @{
        Path              = "DS001:\Operating Systems"
        SourceFile        = $Wim
        DestinationFolder = $WimName
    }
    $osData = Import-MDTOperatingSystem @params -Verbose -ErrorAction Stop
    }
}

#Create Task Sequence for each Operating System
Write-Host "Creating Task Sequence for each imported Operating System"
$OperatingSystems = Get-ChildItem -Path "DS001:\Operating Systems"

if ($OperatingSystems) {
    [int]$counter = 0
    foreach ($OS in $OperatingSystems){
    $Counter++
    $WimName = Split-Path -Path $OS.Source -Leaf
    $params = @{
        Path                = "DS001:\Task Sequences"
        Name                = "$($OS.Description) in $WimName"
        Template            = "Client.xml"
        Comments            = ""
        ID                  = $Counter
        Version             = "1.0"
        OperatingSystemPath = "DS001:\Operating Systems\$($OS.Name)"
        FullName            = "fullname"
        OrgName             = "org"
        HomePage            = "about:blank"
        Verbose             = $true
        ErrorAction         = "Stop"
    }
    Import-MDTTaskSequence @params
    }
}

if (!$wimPath) {
    Write-Host "Skipping as no WIM found"
}

#Edit Bootstrap.ini
$bootstrapIni = @"
[Settings]
Priority=Default
[Default]
DeployRoot=\\$env:COMPUTERNAME\DeploymentShare$
SkipBDDWelcome=YES
UserDomain=$env:COMPUTERNAME
UserID=$localUser
UserPassword=$ServiceAccountPassword
"@

Set-Content -Path "$DeploymentShareDrive\DeploymentShare\Control\Bootstrap.ini" -Value $bootstrapIni -Force -Confirm:$false

#Create LiteTouch Boot WIM & ISO
Write-Host "Creating LiteTouch Boot Media"
Update-MDTDeploymentShare -path "DS001:" -Force -Verbose -ErrorAction Stop

if ($Applications) {
    $AppList = @"
[
    {
        "name": "Libre Office",
        "version": "6.2.2",
        "download": "https://mirror.dkm.cz/tdf/libreoffice/stable/6.2.2/win/x86_64/LibreOffice_6.2.2_Win_x64.msi",
        "filename": "LibreOffice_6.2.2_Win_x64.msi",
        "install": "msiexec /i LibreOffice_6.2.2_Win_x64.msi /qb"
    },
    {
        "name": "JAVA",
        "version": "8.201",
        "download": "https://sdlc-esd.oracle.com/ESD6/JSCDL/jdk/8u201-b09/42970487e3af4f5aa5bca3f542482c60/JavaSetup8u201.exe?GroupName=JSC&FilePath=/ESD6/JSCDL/jdk/8u201-b09/42970487e3af4f5aa5bca3f542482c60/JavaSetup8u201.exe&BHost=javadl.sun.com&File=JavaSetup8u201.exe&AuthParam=1554392008_beb6275f09b8afed82665c353c9de72a&ext=.exe",
        "filename": "JavaSetup8u201.exe",
        "install": "JavaSetup8u201.exe /S"
    },
    {
        "name": "Adobe Reader DC",
        "version": "2015.007.20033.02",
        "download": "http://ardownload.adobe.com/pub/adobe/reader/win/AcrobatDC/1500720033/AcroRdrDC1500720033_MUI.exe",
        "filename": "AcroRdrDC1500720033_MUI.exe",
        "install": "AcroRdrDC1500720033_MUI.exe /sAll /rs /rps /msi /norestart /quiet ALLUSERS=1 EULA_ACCEPT=YES"
    }
]
"@
    $AppList = ConvertFrom-Json $AppList

    foreach ($Application in $AppList) {
        New-Item -Path "$PSScriptRoot\mdt_apps\$($application.name)" -ItemType Directory -Force
        Start-BitsTransfer -Source $Application.download -Destination "$PSScriptRoot\mdt_apps\$($application.name)\$($Application.filename)"
        $params = @{
            Path                  = "DS001:\Applications"
            Name                  = $Application.name
            ShortName             = $Application.name
            Publisher             = ""
            Language              = ""
            Enable                = "True"
            Version               = $Application.version
            Verbose               = $true
            ErrorAction           = "Stop"
            CommandLine           = $Application.install
            WorkingDirectory      = ".\Applications\$($Application.name)"
            ApplicationSourcePath = "$PSScriptRoot\mdt_apps\$($application.name)"
            DestinationFolder     = $Application.name
        }
        Import-MDTApplication @params
    }
    Remove-Item -Path "$PSScriptRoot\mdt_apps" -Recurse -Force -Confirm:$false
}

#Finish
Write-Host "MDT installed"