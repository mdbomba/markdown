# access/setvpnremoteip

**Category**: VPN  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-LmVpnRemoteIp`

## Description

Updates lm VPN remote IP.

## Endpoint

```text
POST https://<host>:<port>/access/setvpnremoteip?name=<name>&remoteip=<remoteip>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Object name used by the command. |
| `remoteip` | string | Yes | Remoteip IP address. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/setvpnremoteip?name=example-name&remoteip=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- setvpnremoteip operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/setvpnlocalip` — updates lm VPN local IP
- `access/setvpnlocalsubnets` — updates lm VPN local subnet
- `access/setvpnremotesubnets` — updates lm VPN remote subnet
