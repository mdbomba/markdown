# LoadMaster REST API Reference

Per-endpoint documentation for the Kemp LoadMaster REST API, organized by feature area. Each markdown file documents one API primitive with parameters, examples, and live-validated behavior notes.

**Firmware validated**: `7.2.63.2.RELEASE` (also tested on `7.2.54.12.22642.RELEASE`)

## API Interfaces

The LoadMaster exposes two API interfaces:

| Interface | Endpoint | Format | Use Case |
|-----------|----------|--------|----------|
| **APIv2** (recommended) | `POST /accessv2` | JSON | All post-license operations |
| **APIv1** (fallback) | `GET /access/<cmd>?params` | XML | Pre-license flow, quick debugging |

See `system/access-set.md` for detailed APIv1 vs APIv2 comparison.

## Categories

| Category | Commands | Description |
|----------|----------|-------------|
| [licensing](licensing/) | 7 | EULA acceptance, online/offline license activation |
| [licensing-extra](licensing-extra/) | 9 | SPLA, ASL on-premise, kill/deactivate commands |
| [system](system/) | 43 | Get/set parameters, reboot, backup/restore, firmware, logging |
| [virtual-services](virtual-services/) | 17 | Create, modify, delete VS; template deployment, Kubernetes |
| [real-servers](real-servers/) | 8 | Add/remove RS, enable/disable, health checks |
| [rules](rules/) | 12 | Content rules (L7 match, header, URL, body) |
| [network](network/) | 20 | Interfaces, routes, VLANs, VxLANs, bonds |
| [certificates](certificates/) | 37 | TLS certs, cipher sets, Let's Encrypt, ACME, OCSP |
| [waf](waf/) | 30 | Web Application Firewall rules, audit logs |
| [geo](geo/) | 64 | Global Server Load Balancing (FQDN, clusters, sites, IP ACLs) |
| [sso](sso/) | 15 | SSO domains (SAML, LDAP, RADIUS, KCD), session management |
| [users](users/) | 20 | Local/remote admin users, API keys, permissions |
| [ldap](ldap/) | 11 | LDAP endpoint configuration, packet routing filter |
| [ha](ha/) | 14 | High Availability (HA pairs, Azure/AWS/Cloud HA) |
| [rate-limiting](rate-limiting/) | 20 | CPS/RPS/bandwidth/connection limits |
| [vpn](vpn/) | 17 | IPsec VPN connections (IKEv1/v2) |
| [diagnostics](diagnostics/) | 13 | Ping, traceroute, TCP dump, process info |
| [hosts](hosts/) | 3 | /etc/hosts entries management |
| [templates](templates/) | 4 | VS template upload, list, delete |

**Total**: 364 documented API primitives

## Document Format

Each endpoint file includes:
- Category, firmware tested, PowerShell cmdlet mapping
- Endpoint URL and HTTP method
- Parameter table (type, required, description)
- Example request and response
- Live validation notes (from 2026-05-28 and 2026-06-16 testing sessions)
- See Also links to related commands

## Notes

- The official 2022 REST reference and the PowerShell SDK module were used as primary documentation sources.
- All files have been enhanced with live-validated behavior from actual LoadMaster appliances.
- APIv1 responses are XML; APIv2 responses are JSON.