# IPv4 settings
$internalStaticIPv4="192.168.248.10"
$internalPrefixLength=24
$internalDefaultGateway="192.168.248.10"


## Rename adapters
Write-Host("Renaming adapters to External and Internal...")
Rename-NetAdapter -Name "Ethernet" -NewName "External"
Rename-NetAdapter -Name "Ethernet 2" -NewName "Internal"

## Set external adapter to auto and internal adapter to static
# Write-Host("Setting external IP to dhcp...")
# Get-NetAdapter -Name "External" | Set-NetIPInterface -Dhcp Enabled
Write-Host("Setting external DNS to dhcp...")
Set-DnsClientServerAddress -InterfaceAlias "External" -ResetServerAddresses

Write-Host("Setting Internal IP to static...")
Set-NetIPAddress -InterfaceAlias "Internal" -IPAddress $internalStaticIPv4 -PrefixLength $internalPrefixLength
Write-Host("Setting Internal DNS to static...")
Set-DnsClientServerAddress -InterfaceAlias "Internal" -ServerAddresses $internalStaticIPv4

