# access/downloadowaspcustomdata

**Category**: WAF  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Export-OWASPCustomRuleData`

## Description

Exports owaspcustom rule data.

## Endpoint

```text
GET https://<host>:<port>/access/downloadowaspcustomdata?force=<force>
```

## HTTP Method

`GET` — read/query operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `force` | boolean | No | Force value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/downloadowaspcustomdata?force=example" -o downloadowaspcustomdata.out
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- downloadowaspcustomdata fields -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/addowaspcustomdata` — creates owaspcustom rule data
- `access/delowaspcustomdata` — handles owaspcustom rule data
