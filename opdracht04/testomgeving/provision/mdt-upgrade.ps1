Write-Host "Upgrading MDT"
choco upgrade -y mdt

Write-Host "Upgrading ADK"
choco upgrade -y windows-adk
choco upgrade -y windows-adk-winpe
