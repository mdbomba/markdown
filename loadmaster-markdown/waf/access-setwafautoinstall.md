# access/setwafautoinstall

**Category**: WAF  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Sets wafautoinstall.

## Endpoint

```text
POST https://<host>:<port>/access/setwafautoinstall?enable=<enable>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `enable` | boolean | Yes | Boolean-style enable flag used by the endpoint. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/setwafautoinstall?enable=1"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- setwafautoinstall operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/downloadwafcustomdata` — exports WAF custom rule data
- `access/enablewafautoinstall` — enables wafautoinstall
- `access/setwafinstalltime` — sets wafinstalltime
