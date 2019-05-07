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
    wdsutil /verbose /progress /initialize-server /server:DC /remInst:"$InstallDrive\remoteInstall"

    # $answerclients="all"
    # $adminapprove="disabled"
    # $bootpath="boot\x86\wdsnbp.com"

    # wdsutil /set-server /answerclients:$answerclients
    # wdsutil /set-server /autoaddpolicy$adminapprove
} catch {
    Write-Warning "- Could not initialize the Windows Deployment Services PowerShell module"
}


Write-Host("Adding Boot image WDS Server...")
try {
    # last resort als alles ni werkt, proberen met dit te verranderen naar LiteTouchPE_x64.wim
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

#####################
####### TODO ########
## Look into these ##
#####################
# Warning: Could not find a description for a message that was meant to
#     DC: 
#     DC:          be displayed.
#     DC: 
#     DC: Message ID: 0x4104080A

# An error occurred while trying to execute the command.
#     DC: 
#     DC: Error Code: 0x41D
#     DC: 
#     DC: Error Description: The service did not respond to the start or control request in a timely fashion.

# ERROR: There are no more endpoints available from the endpoint mapper.t§

# error in adding image copy pasten
# error in import image copy pasten
# make share of \\DC.example.com\REMINST
