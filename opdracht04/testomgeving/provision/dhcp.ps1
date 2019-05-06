# DHCP settings
$dhcpStartRange="192.168.248.10"
$dhcpEndRange="192.168.248.30"
$dhcpSubnet="255.255.255.0"
$internalStaticIPv4="192.168.248.10"
$scopeid="192.168.248.0"

## Install DHCP
Write-Host("Installing DHCP...")
Install-WindowsFeature -Name "DHCP" -IncludeManagementTools

## Make scope for clients
### Note: dunno of scopid juist is, of het wel het ip van de internal adapter is
Write-Host("Configuring DHCP scope...")
Add-DhcpServerV4Scope -Name "DHCP Scope" -StartRange $dhcpStartRange -EndRange $dhcpEndRange -SubnetMask $dhcpSubnet

Set-DhcpServerV4OptionValue -DnsServer $internalStaticIPv4 -Router $internalStaticIPv4

Set-DhcpServerv4Scope -ScopeId $scopeid -LeaseDuration 1.00:00:00

Restart-service dhcpserver

Set-DhcpServerv4Scope -ScopeId $scopeid -State Active


## Configure DHCP settings for WDS
### TODO - check if these are set correct
Write-Host("Configuring DHCP for WDS...")
Set-DhcpServerv4OptionValue -ScopeId $scopeid -OptionId 066 -Value $internalStaticIPv4
Set-DhcpServerv4OptionValue -ScopeId $scopeid -OptionId 067 -Value "boot\x64\wdsnbp.com"
Set-DhcpServerv4OptionValue -ScopeId $scopeid -OptionId 015 -Value "example.com"
Set-DhcpServerv4OptionValue -ScopeId $scopeid -DnsServer $internalStaticIPv4


