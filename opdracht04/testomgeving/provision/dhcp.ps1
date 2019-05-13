# DHCP settings
$DNSServerIP="192.168.248.10"
$DHCPServerIP="192.168.248.10"
$StartRange="192.168.248.50"
$EndRange="192.168.248.100"
$Subnet="255.255.255.0"
$RouterIP="192.168.248.10"
$MDTServer = (get-wmiobject win32_computersystem).Name 

Write-Host("Installing DHCP...")
Install-WindowsFeature -Name "DHCP" -IncludeManagementTools

Write-Host("Configuring DHCP scope...")
Add-DhcpServerV4Scope -Name "DHCP Scope" -StartRange $StartRange -EndRange $EndRange -SubnetMask $Subnet
Set-DhcpServerV4OptionValue -DnsServer $DNSServerIP -Router $RouterIP
Set-DhcpServerv4Scope -ScopeId $DHCPServerIP -LeaseDuration 1.00:00:00

Write-Host("Configuring DHCP for WDS...")
Add-DhcpServerv4OptionDefinition -ComputerName $MDTServer -Name PXEClient -Description "PXE Support" -OptionId 060 -Type String
Set-DhcpServerv4OptionValue -ComputerName $MDTServer -ScopeId $DHCPServerIP -OptionId 060 -Value "PXEClient"


### volgens yt video: scopid=ip range dat de pxe info zal ontvangen, previously stond het op ip van de server
Set-DhcpServerv4OptionValue -ScopeId $DHCPServerIP -OptionId 066 -Value $DHCPServerIP
# for BIOS
Set-DhcpServerv4OptionValue -ScopeId $DHCPServerIP -OptionId 067 -Value "boot\x86\wdsnbp.com"
# for uefi
Set-DhcpServerv4OptionValue -ScopeId $DHCPServerIP -OptionId 067 -Value " boot\x86\wdsmgfw.efi"
# Set-DhcpServerv4OptionValue -ScopeId $DHCPServerIP -OptionId 067 -Value "smsboot\x86\wdsnbp.com"
# Set-DhcpServerv4OptionValue -ScopeId $DHCPServerIP -OptionId 067 -Value "\smsboot\x86\wdsnbp.com"
# Set-DhcpServerv4OptionValue -ScopeId $DHCPServerIP -OptionId 015 -Value "example.com"
# Set-DhcpServerv4OptionValue -ScopeId $DHCPServerIP -DnsServer $DNSServerIP

Restart-service dhcpserver

# Set-DhcpServerv4Scope -ScopeId $DHCPServerIP -State Active
