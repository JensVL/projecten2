# IPv4 settings
$internalStaticIPv4=192.168.248.10
$internalPrefixLength=24
$internalDefaultGateway=""


## Rename adapters
Write-Host("Renaming adapters to External and Internal...")
Rename-NetAdapter -Name "Adapter" -NewName "External"
Rename-NetAdapter -Name "Adapter 2" -NewName "Internal"

## Set external adapter to auto and internal adapter to static
Write-Host("Fixing External and Internal IP settngs...")
Get-NetAdapter -Name "External" | Set-NetIPInterface -Dhcp Enabled
New-NetIPAddress -InterfaceAlias "Internal" -IPv4Address $internalStaticIPv4 -PrefixLength $internalPrefixLength -DefaultGateway $internalDefaultGateway

## Fix external dns
Set-DnsClientServerAddress -InterfaceAlias "External" -ResetServerAddresses

## Fix Internal dns
Set-DnsClientServerAddress -InterfaceAlias "Internal" -ServerAddresses $internalStaticIPv4

