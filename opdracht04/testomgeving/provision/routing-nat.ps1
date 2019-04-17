Write-Host("Installing and configuring Routing...")
Install-RemoteAccess -VpnType Vpn

Write-Host("Configuring netsh...")
Start-Process netsh -ArgumentList '-f C:\vagrant\povision\routing-config.txt'
Write-Host("Starting Remote Access...")
net start remoteaccess
Write-Host("Configuring netsh...")
Start-Process netsh -ArgumentList '-f C:\vagrant\povision\routing-config.txt'

