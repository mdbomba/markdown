# access/modiface

**Category**: network  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-NetworkInterface`

## Description

Modifies a network interface configuration, including IP address assignment.

## Endpoint

```text
GET https://<host>:<port>/access/modiface?iface=<id>&addr=<ip/cidr>
```

## HTTP Method

`GET` — despite modifying state, this uses GET with query-string parameters (legacy API pattern).

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `iface` | integer | Yes | Interface ID (`0` = eth0, `1` = eth1, etc.) |
| `addr` | string | No | IP address in CIDR notation (e.g., `10.0.0.14/24`) |
| `mtu` | integer | No | MTU size for the interface |
| `gw` | string | No | Default gateway IP address |

## Example Request

```bash
# Change management interface (eth0) IP address
curl -sk -u "bal:PASSWORD" "https://10.0.0.205:443/access/modiface?iface=0&addr=10.0.0.14/24"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>Address changed</Success>
</Response>
```

## Live Validation (2026-06-16)

| Test | Result |
|------|--------|
| `modiface?iface=0&addr=10.0.0.14/24` | `code="ok"` — `Address changed` |
| `modiface?iface=0&addr=10.0.0.14&mask=255.255.255.0` | `code="fail"` — `Network prefix out of range` |
| Verify from new IP after change | `showiface?iface=0` returns `<IPAddress>10.0.0.14/24</IPAddress>` |


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"modiface","iface":"1","addr":"10.0.0.50","mtu":"1","gw":"example"}'
```

## Notes

- The `addr` parameter **must** use CIDR notation (e.g., `10.0.0.14/24`). Separate `mask` parameter is not supported and returns an error.
- After changing the management interface IP, the appliance is **only reachable at the new address**. All subsequent API calls must target the new IP.
- This is typically used after licensing to assign the production management IP.
- The `interface` parameter name shown in some documentation is incorrect; use `iface` (integer ID).

## See Also

- `access/showiface` — retrieves configuration details for a network interface
- `access/listifconfig` — lists all configured network interfaces
- `access/addadditional` — adds an additional IP address to an interface
