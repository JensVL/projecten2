Write-Host("Installing and configuring Routing...")
Install-RemoteAccess -VpnType Vpn

NETSH
routing ip nat add interface External
routing ip nat set interface External mode=full
routing ip nat add interface Internal

exit