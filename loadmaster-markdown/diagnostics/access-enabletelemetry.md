# access/enabletelemetry

**Category**: diagnostics  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Enable-Telemetry`

## Description

Enables telemetry.

## Endpoint

```text
POST https://<host>:<port>/access/enabletelemetry?enable=<enable>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `iface` | integer | No | Network interface identifier. |
| `enable` | boolean | Yes | Boolean-style enable flag used by the endpoint. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/enabletelemetry?enable=1"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- enabletelemetry operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/getraidinfo` — retrieves lm RAID controller
- `access/showtelemetry` — retrieves telemetry
