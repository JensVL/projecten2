Write-Host "Installing MDT"
choco install -y mdt

Write-Host "Installing ADK"
# choco install -y windows-adk
choco install -y windows-adk-winpe



Write-Host("Creating new partition...")
if(!(Test-Path("E:\"))){
    Get-Partition -DriveLetter C | Resize-Partition -Size 80GB
    New-Partition -DiskNumber 0 -Size 15GB -DriveLetter E
    Format-Volume -DriveLetter E -FileSystem NTFS
}

$imagePath = "C:\Users\vagrant\Downloads\win10x64.iso"
# if available in c:\vagrant\provision then copy else if not in downloadsthen download
if (!(Test-Path $imagePath)) {
    if (Test-Path("C:\vagrant\provision\Win10_1803_English_x64.iso")) {
        # copy to downloads
        Write-Host("Copying from shared folder...")
        Copy-Item "C:\vagrant\provision\Win10_1803_English_x64.iso" -Destination "C:\Users\vagrant\Downloads"
        Rename-Item "C:\Users\vagrant\Downloads\Win10_1803_English_x64.iso" -NewName "win10x64.iso"
    } else {
        Write-Host("Downloading iso...")
        (New-Object System.Net.Webclient).DownloadFile("https://software-download.microsoft.com/download/sg/17763.107.101029-1455.rs5_release_svc_refresh_CLIENT_LTSC_EVAL_x64FRE_en-us.iso","c:\Users\vagrant\Downloads\win10x64.iso")
    }
} else {
    Write-Host("iso is present...")
}

# try{
    Write-Host("Mounting iso...")
    $isoDrive = (Get-DiskImage -ImagePath $imagePath | Get-Volume)
    # For some unknown reason, $isoDrive is not interpreted well
    # If you should encounter an error like 
    # Exception setting "Path": "Unable to cast object of type 'System.IO.DirectoryInfo' to type 'Microsoft.BDD.PSSnapIn.MDTObject'."
    # Consider replacing $isoDrive in the if statement with $mounted
    # and uncomment the following line
    # $exists = !([string]::IsNullOrEmpty($isoDrive))
    if (!($isoDrive)) {
        Mount-DiskImage -ImagePath $imagePath -StorageType ISO
        $isoDrive = (Get-DiskImage -ImagePath $imagePath | Get-Volume).DriveLetter
    }
    $isoDrive = (Get-DiskImage -ImagePath $imagePath | Get-Volume).DriveLetter
    Write-Host("Driveletter: "+$isoDrive)
# } catch {
#     Write-Host("Failed to retrieve and/or mount iso")
# }

Add-PSSnapIn -Name Microsoft.BDD.PSSnapIn
Write-Host("Creating deployment share")
$MDTServer = (get-wmiobject win32_computersystem).Name 
$InstallDrive = "E:" 
New-Item -Path $InstallDrive\MDTProduction -ItemType directory 
New-PSDrive -Name "DS001" -PSProvider "MDTProvider" -Root "$InstallDrive\MDTProduction" -Description "MDT Production" -NetworkPath "\\$MDTServer\MDTProduction$" | add-MDTPersistentDrive 
New-SmbShare -Name MDTProduction$ -Path "$InstallDrive\MDTProduction" -ChangeAccess EVERYONE 

Write-Host("Importing os...")
$params = @{
    Path                = "DS001:\Operating Systems"
    SourcePath          = "D:\"
    DestinationFolder   = "Windows10"
}    
Import-MDTOperatingSystem @params -Verbose -ErrorAction Stop


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


# Edit Bootstrap.ini
$bootstrapIni = @"
[Settings]
Priority=Default
[Default]
DeployRoot=\\$MDTServer\MDTProduction$
SkipBDDWelcome=YES
UserDomain=$MDTServer
UserID=vagrant
UserPassword=vagrant
"@

Set-Content -Path "$InstallDrive\MDTProduction\Control\Bootstrap.ini" -Value $bootstrapIni -Force -Confirm:$false

#Create LiteTouch Boot WIM & ISO
Write-Host "Creating LiteTouch Boot Media"

Write-Host "Restoring share..."
Restore-MDTPersistentDrive -Verbose

Write-Host "Get share..."
Get-PSDrive -PSProvider Microsoft.BDD.PSSnapIn\MDTProvider

Write-Host "Updating share"
# From here the followng error occurs
# DISM was unable to set the system root (target path) for the Windows PE image, so the update process cannot continue.
# Noticed that there was also a line saying
# VERBOSE: The system cannot find the path specified.
# Some sources suggest installing the WinPE
# choco install -y windows-adk-winpe
# At the very top: 
# "choco install -y windows-adk" 
# was changed to 
# "choco install -y windows-adk-winpe"
Update-MDTDeploymentShare -path "DS001:" -Force -Verbose -ErrorAction Stop

Write-Host "Compiling applications..."
[switch] $Applications = $true
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

Finish
Write-Host "MDT installed"




# # Fix - strange permissions set by mdt
# # Configure NTFS Permissions for the MDT Build Lab deployment share
# $DeploymentShareNTFS = "E:\MDTBuildLab"
# icacls $DeploymentShareNTFS /grant '"Users":(OI)(CI)(RX)'
# icacls $DeploymentShareNTFS /grant '"Administrators":(OI)(CI)(F)'
# icacls $DeploymentShareNTFS /grant '"SYSTEM":(OI)(CI)(F)'
# icacls "$DeploymentShareNTFS\Captures" /grant '"VIAMONSTRA\MDT_BA":(OI)(CI)(M)'
 
# # Configure Sharing Permissions for the MDT Build Lab deployment share
# $DeploymentShare = "MDTBuildLab$"
# Grant-SmbShareAccess -Name $DeploymentShare -AccountName "EVERYONE" -AccessRight Change -Force
# Revoke-SmbShareAccess -Name $DeploymentShare -AccountName "CREATOR OWNER" -Force




#Import WIM
# Write-Host "Checking for wim files"
# $Wims = Get-ChildItem $PSScriptRoot -Filter "*.wim" | Select-Object -ExpandProperty FullName ### Ze gaan er denk ik van uit dat u .wim file in een niveau boven U root staat
# if (!$Wims) {
#     Write-Host "No wim files found"
# }

# if ($Wims) {
#     foreach($Wim in $Wims){
#     $WimName = Split-Path $Wim -Leaf
#     $WimName = $WimName.TrimEnd(".wim")
#     Write-Host "$WimName found - will import"
#     $params = @{
#         Path              = "DS001:\Operating Systems"
#         SourceFile        = $Wim
#         DestinationFolder = $WimName
#     }
#     $osData = Import-MDTOperatingSystem @params -Verbose -ErrorAction Stop
#     }
# }
