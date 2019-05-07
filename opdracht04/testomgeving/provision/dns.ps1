Get-WindowsFeature -Name DNS -IncludeManagmentTools

# add forward lookup zone
Add-DnsServerPrimaryone -name example.com -zoneFile example.com.DNS -dynamicUpdate nonsecureandsecure

# add a-record
# add-dnsServerresourcerecordA -name client123 -zonename example.com -allowupdateany -ipv4address 192.168.56.11