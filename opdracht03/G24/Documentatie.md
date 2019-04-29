# Devices 
## TelenetRouter1
- S0/1/0 -> ISP (78.0.0.2)
  - VLAN: Native
  - IP: 78.0.0.1
- G0/0/1 -> Switch1
  - G0/0/1.10
    - VLAN: Office
    - IP: 192.168.10.1
  - G0/0/1.20
      - VLAN: Guests
      - IP: 192.168.20.1
  - G0/0/1.66
      - VLAN: Management
      - IP: 192.168.66.1

## Switch1
- G0/1 (trunk) -> TelenetRouter
  - VLAN: Native
- Fa0/1 -> IP Phone 1 -> PC1
  - VLAN:  Office & VOICE
- Fa0/2 -> IP Phone 2 -> PC2
  - VLAN: Office & VOICE
- Fa0/3 -> IP Phone 3 -> PC3
  - VLAN: Office & VOICE
- Fa0/4 -> Printer1
  - VLAN: Office
- Fa0/5 -> Printer2
  - VLAN: Office
- Fa0/6 -> Office Access Point
  - VLAN: Office
- Fa0/7 -> Guests Access Point
  - VLAN: Guests

## Office Access Point
- SSID: Office
- AuthenticatieProtocol: WPA2-PSK 
- Password: p2ops-g10

## Guests Access Point
- SSID: Guests
- AuthenticatieProtocol: WPA2-PSK 
- Password: p2ops-g10

# VLAN's
- 1: Default
- 10: Office
  - Domain: vastgoedOffice.com
- 20: Guests
  - Domain: vastgoedGuests.com
- 66: Management
  - Domain: vastgoed.com
- 99: Native
- 150: VOICE
