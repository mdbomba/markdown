# access/fetchleaccount

**Category**: certificates  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Get-LEAccount`

## Description

Retrieves stored Let's Encrypt account details.

## Endpoint

```text
GET https://<host>:<port>/access/fetchleaccount?path=<path>[&...]
```

## HTTP Method

`GET` — read/query operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `path` | string | Yes | Local file path supplied to the PowerShell cmdlet; represented as uploaded or downloaded content in REST usage. |
| `password` | string | No | Password value associated with the command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/fetchleaccount?path=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- fetchleaccount fields -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Certificate and licensing workflows can take noticeably longer than simple queries. A client timeout of `max_time=60` is recommended.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/renewlecert` — requests renewal of an existing Let's Encrypt certificate
- `access/registerleaccount` — registers a Let's Encrypt account for certificate automation
- `access/leaccountinfo` — retrieves leaccount info
