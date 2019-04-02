# DHCP settings
$dhcpStartRange=192.168.248.10
$dhcpEndRange=192.168.248.30
$dhcpSubnet=255.255.255.0
$internalStaticIPv4=192.168.248.10

## Install DHCP
Write-Host("Installing DHCP...")
Install-WindowsFeature -Name "DHCP" –IncludeManagementTools

## Make scope for clients
### Note: dunno of scopid juist is, of het wel het ip van de internal adapter is
Write-Host("Configuring DHCP scope...")
Add-DhcpServerV4Scope -Name "DHCP Scope" -StartRange $dhcpStartRange -EndRange $dhcpEndRange -SubnetMask $dhcpSubnet

Set-DhcpServerV4OptionValue -DnsServer $internalStaticIPv4 -Router $internalStaticIPv4

Set-DhcpServerv4Scope -ScopeId $internalStaticIPv4 -LeaseDuration 1.00:00:00

Restart-service dhcpserver

Set-DhcpServerv4Scope -ScopeId $internalStaticIPv4 -State Active


## Configure DHCP settings for WDS
### TODO
# Write-Host("Configuring DHCP for WDS...")
# Set-DhcpServerv4OptionValue -ScopeId $internalStaticIPv4 -OptionId 066 -Value $internalStaticIPv4
# Set-DhcpServerv4OptionValue -ScopeId $internalStaticIPv4 -OptionId 067 -Value "boot\x64\wdsnbp.com"
# Set Domain Name Set-DhcpServerv4OptionValue -ScopeId $internalStaticIPv4 -OptionId 015 -Value "example.com"
# Set-DhcpServerv4OptionValue -ScopeId $internalStaticIPv4 -DnsServer $internalStaticIPv4


