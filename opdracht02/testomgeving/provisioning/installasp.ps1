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