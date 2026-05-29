# access/geoacl

**Category**: GEO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Handles geoacl.

## Endpoint

```text
POST https://<host>:<port>/access/geoacl?enable=<enable>&hour=<hour>&addr=<addr>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `enable` | boolean | Yes | Boolean-style enable flag used by the endpoint. |
| `hour` | string | Yes | Hour value for this command. |
| `addr` | string | Yes | IP address value used by the command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/geoacl?enable=1&hour=example&addr=198.51.100.10"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- geoacl operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- The reference guide shows multiple endpoint forms for this command, including alternate addressing by ID or name where applicable.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/disablegeo` — disables lm GEO pack
- `access/isgeoenabled` — tests lm GEO enabled
- `access/geostats` — retrieves GEO statistics
