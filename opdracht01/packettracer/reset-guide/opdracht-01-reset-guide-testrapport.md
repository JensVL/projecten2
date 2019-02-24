# Testrapport Opdracht 1: Reset guide 

Uitgevoerd op: 24 februari 2019  
Github commit:  e28752fe82393257e91b8e8c8af947ff6d4f6f5f  

## Switch
Uitvoerder(s) test: Matthias Van De Velde  

### Reload config
> Step 6, what password should be used?  

The output matches the provided output  

### Factory reset
> You can use the settings from the previous test.  

The output matches the provided output  

### Manual reload config
> TODO in classroom  

### Manual factory reset
> TODO in classroom  

## Router
Uitvoerder(s) test: Nathan Cammerman  

### Reload config(reset running config naar startup config)
I used a new router(2901) because there wasn't a start project mentioned or specific router.
This resulted in a slightly different outcome in the prompt.
Expected: GigabitEthernet0/0 | 192.168.16.1 | YES | manual | up | up |
Actual: GigabitEthernet0/0 | 192.168.16.1 | YES | NVRAM | administratively down | down |

### Factory reset
I used a new router(2901) because there wasn't a start project mentioned or specific router.
This resulted in a slightly different outcome in the prompt.
Expected:
| Interface | IP-Address | OK? | Method | Status | Protocol |
|---|---|---|---|---|---|
| GigabitEthernet0/0 | unassigned | YES | unset | administratively down | down |
| GigabitEthernet0/1 | unassigned  | YES | unset |administratively down | down |
| Serial0/0/0 | unassigned | YES | unset | administratively down | down |
| Serial0/0/1 | unassigned | YES | unset | administratively down | down |
| Vlan1 | unassigned | YES | unset | administratively down | down |

Actual:
| Interface | IP-Address | OK? | Method | Status | Protocol |
|---|---|---|---|---|---|
| GigabitEthernet0/0 | unassigned | YES | NVRAM | administratively down | down |
| GigabitEthernet0/1 | unassigned  | YES | NVRAM |administratively down | down |
| Vlan1 | unassigned | YES | NVRAM | administratively down | down |
### Manual reload config
### Manual factory reset