# access/tcpdump

**Category**: diagnostics  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Trace-TcpTraffic`

## Description

Handles TCP traffic.

## Endpoint

```text
POST https://<host>:<port>/access/tcpdump?maxpackets=<maxpackets>&maxtime=<maxtime>&interface=<interface>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `maxpackets` | integer | No | Maxpackets value for this command. |
| `maxtime` | integer | No | Maxtime value for this command. |
| `interface` | string | No | Interface value for this command. |
| `port` | string | No | Virtual service port number. |
| `address` | string | No | Address IP address. |
| `tcpoptions` | string | No | Tcpoptions value for this command. |
| `path` | string | No | Local file path supplied to the PowerShell cmdlet; represented as uploaded or downloaded content in REST usage. |
| `force` | boolean | No | Force value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/tcpdump?maxpackets=example&maxtime=example&interface=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- tcpdump operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/showadaptive` — retrieves adc adaptive health check
- `access/modadaptive` — updates adc adaptive health check
- `access/resolvenow` — updates network dnscache
