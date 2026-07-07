# Network

Network interface management including IP addressing, VLANs, VxLANs, bonding, static routes, and cache/compression control.

## Commands (20)

### Interfaces
| Command | Description |
|---------|-------------|
| [`access/showiface`](access-showiface.md) | Show interface configuration (IP in CIDR format) |
| [`access/modiface`](access-modiface.md) | Modify interface IP/settings (uses CIDR notation) |
| [`access/listifconfig`](access-listifconfig.md) | List all configured interfaces |
| [`access/addadditional`](access-addadditional.md) | Add additional IP to interface |
| [`access/deladditional`](access-deladditional.md) | Remove additional IP from interface |

### Bonding
| Command | Description |
|---------|-------------|
| [`access/createbond`](access-createbond.md) | Register a bonded interface |
| [`access/addbond`](access-addbond.md) | Add interface to bond |
| [`access/delbond`](access-delbond.md) | Remove interface from bond |
| [`access/unbond`](access-unbond.md) | Delete a bonded interface |

### VLANs & VxLANs
| Command | Description |
|---------|-------------|
| [`access/addvlan`](access-addvlan.md) | Add VLAN to interface |
| [`access/delvlan`](access-delvlan.md) | Remove VLAN from interface |
| [`access/addvxlan`](access-addvxlan.md) | Add VxLAN to interface |
| [`access/delvxlan`](access-delvxlan.md) | Remove VxLAN from interface |

### Routing
| Command | Description |
|---------|-------------|
| [`access/addroute`](access-addroute.md) | Add static route |
| [`access/delroute`](access-delroute.md) | Delete static route |
| [`access/showroute`](access-showroute.md) | Show configured routes |

### Cache & Compression
| Command | Description |
|---------|-------------|
| [`access/addnocache`](access-addnocache.md) | Add no-cache exception |
| [`access/delnocache`](access-delnocache.md) | Remove no-cache exception |
| [`access/addnocompress`](access-addnocompress.md) | Add no-compress exception |
| [`access/delnocompress`](access-delnocompress.md) | Remove no-compress exception |

## Key Notes

- Interface IDs: `0` = eth0, `1` = eth1, etc.
- IP addresses use **CIDR notation** (e.g., `10.0.0.14/24`) — not separate mask parameters
- After changing management IP via `modiface`, the appliance only responds on the new address
