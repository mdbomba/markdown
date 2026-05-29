# access/setadminaccess

**Category**: system  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-SecAdminAccess`

## Description

Controls which source addresses are permitted to reach the administrative interface.

## Endpoint

```text
POST https://<host>:<port>/access/setadminaccess?wuiiface=<wuiiface>&wuiport=<wuiport>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `wuiiface` | integer | Yes | Interface used by the administrative web UI. |
| `wuiport` | integer | Yes | Administrative web UI port number. |
| `wuidefaultgateway` | string | No | Default gateway used by the administrative web UI network. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/setadminaccess?wuiiface=1&wuiport=8443"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- setadminaccess operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/stats` — returns current appliance traffic and usage statistics
- `access/vstotals` — returns aggregate totals across configured virtual services
- `access/listapi` — lists the REST primitives currently exposed by the appliance firmware build
