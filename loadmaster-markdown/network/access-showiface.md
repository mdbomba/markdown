# access/showiface

**Category**: network  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Get-NetworkInterface`

## Description

Retrieves configuration details for a network interface.

## Endpoint

```text
GET https://<host>:<port>/access/showiface?iface=<iface>
```

## HTTP Method

`GET` — read/query operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `iface` | integer | No | Network interface identifier. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/showiface?iface=1"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
<Success><Data><Interface>
<Id>0</Id>
<IPAddress>10.0.0.14/24</IPAddress>
<Mtu>1500</Mtu>
<InterfaceType>Port</InterfaceType>
<GeoTrafficEnable>Y</GeoTrafficEnable>
<DefaultInterface>yes</DefaultInterface>
</Interface>
</Data></Success>
</Response>
```

## Live Validation (2026-06-16)

- Successfully retrieved interface 0 (eth0) configuration on firmware 7.2.63.x
- Response fields include: `Id`, `IPAddress` (CIDR notation), `Mtu`, `InterfaceType`, `GeoTrafficEnable`, `DefaultInterface`
- The `iface` parameter is optional — if omitted, returns all interfaces
- IP address is returned in CIDR format (e.g., `10.0.0.14/24`)


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"showiface","iface":"1"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/modiface` — modifies a network interface configuration
