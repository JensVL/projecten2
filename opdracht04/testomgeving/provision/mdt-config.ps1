Write-Host("Creating new partition...")
if(!(Test-Path("E:\"))){
    Get-Partition -DriveLetter C | Resize-Partition -Size 50GB
    New-Partition -DiskNumber 0 -Size 45GB -DriveLetter E
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

Write-Host "Restoring persistent drive..."
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
        "install": "msiexec /i LibreOffice_6.2.2_Win_x64.msi /qb",
        "cookie": ""
    },
    {
        "name": "JAVA",
        "version": "12.0.1",
        "download": "https://download.oracle.com/otn-pub/java/jdk/12.0.1+12/69cfe15208a647278a19ef0990eea691/jdk-12.0.1_windows-x64_bin.exe",
        "filename": "jdk-12.0.1_windows-x64_bin.exe",
        "install": "jdk-12.0.1_windows-x64_bin.exe /S",
        "cookie": "oraclelicense=accept-securebackup-cookie"
    },
    {
        "name": "Adobe Reader DC",
        "version": "2015.007.20033.02",
        "download": "http://ardownload.adobe.com/pub/adobe/reader/win/AcrobatDC/1500720033/AcroRdrDC1500720033_MUI.exe",
        "filename": "AcroRdrDC1500720033_MUI.exe",
        "install": "AcroRdrDC1500720033_MUI.exe /sAll /rs /rps /msi /norestart /quiet ALLUSERS=1 EULA_ACCEPT=YES",
        "cookie": ""
    }
]
"@
    $AppList = ConvertFrom-Json $AppList

    foreach ($Application in $AppList) {
        New-Item -Path "$InstallDrive\mdt_apps\$($Application.name)" -ItemType Directory -Force
        $destination = "$InstallDrive\mdt_apps\$($Application.name)\$($Application.filename)"
        if (![string]::IsNullOrEmpty($Application.cookie)) {
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            $client = new-object System.Net.WebClient 
            $client.Headers.Add([System.Net.HttpRequestHeader]::Cookie, $Application.cookie) 
            $client.DownloadFile($Application.download, $destination)
        } else {
            Start-BitsTransfer -Source $Application.download -Destination $destination
        }
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
            ApplicationSourcePath = "$InstallDrive\mdt_apps\$($Application.name)"
            DestinationFolder     = $Application.name
        }
        Import-MDTApplication @params
    }
    Remove-Item -Path "$InstallDrive\mdt_apps" -Recurse -Force -Confirm:$false
}

Write-Host "MDT installed"