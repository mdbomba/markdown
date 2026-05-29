# access/setvpnsecret

**Category**: VPN  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-LmVpnSecret`

## Description

Updates lm VPN secret.

## Endpoint

```text
POST https://<host>:<port>/access/setvpnsecret?name=<name>&localid=<localid>&remoteid=<remoteid>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Object name used by the command. |
| `localid` | string | Yes | Localid identifier. |
| `remoteid` | string | Yes | Remoteid identifier. |
| `key` | string | Yes | API key value to list or delete. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/setvpnsecret?name=example-name&localid=example&remoteid=example&key=0123456789abcdef"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- setvpnsecret operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/setvpnremoteip` — updates lm VPN remote IP
- `access/setvpnremotesubnets` — updates lm VPN remote subnet
- `access/setvpnpfsdisable` — updates lm VPN pfs disable
