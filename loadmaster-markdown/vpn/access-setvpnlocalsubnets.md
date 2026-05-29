# access/setvpnlocalsubnets

**Category**: VPN  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-LmVpnLocalSubnet`

## Description

Updates lm VPN local subnet.

## Endpoint

```text
POST https://<host>:<port>/access/setvpnlocalsubnets?name=<name>&localsubnets=<localsubnets>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Object name used by the command. |
| `localsubnets` | string | Yes | Localsubnets value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/setvpnlocalsubnets?name=example-name&localsubnets=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- setvpnlocalsubnets operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/setvpnaddr` — updates lm VPN addrs
- `access/setvpnlocalip` — updates lm VPN local IP
- `access/setvpnremoteip` — updates lm VPN remote IP
