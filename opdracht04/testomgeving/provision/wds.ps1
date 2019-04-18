# Bootfile moet eerst gemaakt zijn voordat dit uitgevoerd wordt want ze gebruiken deze WIM file.
# Install WDS
## TODO: Boot image, installationgroup name en pad instellen
## TODO: fix error occuring on line 154
## Exception setting "Path": "Unable to cast object of type 'System.IO.DirectoryInfo' to type 'Microsoft.BDD.PSSnapIn.MDTObject'."
## mabe with [string]::Format('{0}',$isodrive) -> for now testing with hardcoded driveletter

Write-Host("Installing WDS...")
try { 
    Write-Host "Imports the Windows Deployment Services PowerShell module"
    Install-WindowsFeature wds-deployment -includemanagementtools
    Write-Host "- Windows Deployment Services PowerShell module imported"
} catch {
    Write-Warning "- Could not import the Windows Deployment Services PowerShell module from first location"
    Write-Warning "- Trying to Import the WDS PowerShell module again"
    try {
        Write-Host "Imports the Windows Deployment Services PowerShell module"
        Install-WindowsFeature wds-deployment -includemanagementtools
            Write-Host "- Windows Deployment Services PowerShell module imported"
    } catch {
        Write-Warning "- Could not import the Windows Deployment Services PowerShell module"
        Break
    }
}


Write-Host("Initializing WDS...")
try {
    # Change dirs to folder that is used in mdt.ps1
    $wdsUtilResults = wdsutil /initialize-server /server:example.com /remInst:"E:\RemInstall"
    $wdsUtilResults | select -last 1
} catch {
    Write-Warning "- Could not initialize the Windows Deployment Services PowerShell module"
}


Write-Host("Adding Boot image WDS Server...")
try {
    # # location of .wim file created in mdt.ps1
    # Import-WdsBootImage -Path "D:\sources\boot.wim"
} catch {
    Write-Warning "- Could not initialize the Windows Deployment Services PowerShell module"
}

Write-Host("Importing the WDS Install Image...")
try{
    New-WdsInstallImageGroup -Name "desktops" 
    # # Change dirs to the ones used in mdt.ps1
    # Get-WindowsImage -imagePath "D:\sources\install.wim" | select Imagename 
    $imageName = 'Windows 10 Pro' 
    # Import-WdsInstallImage -ImageGroup "desktops" -Path "D:\sources\install.wim" -ImageName $imageName
} catch {
    Write-Warning "- Could not initialize the Windows Deployment Services PowerShell module"
}

Write-Host("Installed WDS")
