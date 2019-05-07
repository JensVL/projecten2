# DHCP settings
$DNSServerIP="192.168.248.10"
$DHCPServerIP="192.168.248.10"
$StartRange="192.168.248.50"
$EndRange="192.168.248.100"
$Subnet="255.255.255.0"
$RouterIP="192.168.248.10"

Write-Host("Installing DHCP...")
Install-WindowsFeature -Name "DHCP" -IncludeManagementTools

Write-Host("Configuring DHCP scope...")
Add-DhcpServerV4Scope -Name "DHCP Scope" -StartRange $StartRange -EndRange $EndRange -SubnetMask $Subnet
Set-DhcpServerV4OptionValue -DnsServer $DnsServer -Router $RouterIP
Set-DhcpServerv4Scope -ScopeId $DHCPServerIP -LeaseDuration 1.00:00:00

Write-Host("Configuring DHCP for WDS...")

Add-DhcpServerv4OptionDefinition -ComputerName MyDHCPServer -Name PXEClient -Description "PXE Support" -OptionId 060 -Type String
Set-DhcpServerv4OptionValue -ComputerName MyDHCPServer -ScopeId "MyScope" -OptionId 060 -Value "PXEClient"


### volgens yt video: scopid=ip range dat de pxe info zal ontvangen, previously stond het op ip van de server
Set-DhcpServerv4OptionValue -ScopeId $StartRange -OptionId 066 -Value $DHCPServerIP
# for BIOS
Set-DhcpServerv4OptionValue -ScopeId $StartRange -OptionId 067 -Value "boot\x86\wdsnbp.com"
# for uefi
Set-DhcpServerv4OptionValue -ScopeId $StartRange -OptionId 067 -Value " boot\x86\wdsmgfw.efi"
# Set-DhcpServerv4OptionValue -ScopeId $DHCPServerIP -OptionId 067 -Value "smsboot\x86\wdsnbp.com"
# Set-DhcpServerv4OptionValue -ScopeId $DHCPServerIP -OptionId 067 -Value "\smsboot\x86\wdsnbp.com"
# Set-DhcpServerv4OptionValue -ScopeId $DHCPServerIP -OptionId 015 -Value "example.com"
# Set-DhcpServerv4OptionValue -ScopeId $DHCPServerIP -DnsServer $DNSServerIP

Restart-service dhcpserver

# Set-DhcpServerv4Scope -ScopeId $DHCPServerIP -State Active
