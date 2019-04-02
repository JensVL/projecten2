
Write-Host("Installing Remote Access and Routing...")
## Install RRAS NAT
Enable-NetFirewallRule -DisplayName "File and Printer Sharing (Echo Request - ICMPv4-In)"

Install-WindowsFeature Routing -IncludeAllSubFeature -IncludeManagementTools

## restart -> vagrant reload 





