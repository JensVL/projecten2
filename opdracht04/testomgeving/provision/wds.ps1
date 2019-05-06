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

$InstallDrive = "E:" 


Write-Host("Initializing WDS...")
try {
    wdsutil /verbose /progress /initialize-server /server:DC /remInst:"E:\remoteInstall"
} catch {
    Write-Warning "- Could not initialize the Windows Deployment Services PowerShell module"
}


Write-Host("Adding Boot image WDS Server...")
try {
    # location of .wim file created in mdt.ps1
    Import-WdsBootImage -Path "$InstallDrive\MDTProduction\Operating Systems\Windows10\sources\boot.wim"
} catch {
    Write-Warning "- Could not initialize the Windows Deployment Services PowerShell module"
}

Write-Host("Importing the WDS Install Image...")
try{
    New-WdsInstallImageGroup -Name "desktops" 
    # Change dirs to the ones used in mdt.ps1
    Get-WindowsImage -imagePath "$InstallDrive\MDTProduction\Operating Systems\Windows10\sources\install.wim" | select Imagename 
    $imageName = 'Windows 10 Pro' 
    Import-WdsInstallImage -ImageGroup "desktops" -Path "$InstallDrive\MDTProduction\Operating Systems\Windows10\sources\install.wim" -ImageName $imageName
} catch {
    Write-Warning "- Could not initialize the Windows Deployment Services PowerShell module"
}

Write-Host("Installed WDS")

