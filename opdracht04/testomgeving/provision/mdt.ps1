# TODO: edit all of this so it works
Install-WindowsFeature -Name 'DHCP' –IncludeManagementTools

Add-DhcpServerV4Scope -Name "DHCP Scope" -StartRange 192.168.1.150 -EndRange 192.168.1.200 -SubnetMask 255.255.255.0

Set-DhcpServerV4OptionValue -DnsServer 192.168.1.10 -Router 192.168.1.1

Set-DhcpServerv4Scope -ScopeId 192.168.1.10 -LeaseDuration 1.00:00:00

Restart-service dhcpserver



Set-DhcpServerv4OptionValue -ScopeId "10.10.54.0" -OptionId 066 -Value "10.10.0.45"
Set-DhcpServerv4OptionValue -ScopeId "10.10.54.0" -OptionId 067 -Value "boot\x64\wdsnbp.com"
Set Domain Name Set-DhcpServerv4OptionValue -ScopeId "10.10.54.0" -OptionId 015 -Value "blogginglab.com"

Set-DhcpServerv4OptionValue -ScopeId "10.10.54.0" -DnsServer 10.10.54.4,10.10.54.5



Install-WindowsFeature Routing -IncludeManagementTools