# access/modiploc

**Category**: GEO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-GeoIPRangeCoordinates`

## Description

Updates GEO IP range coordinates.

## Endpoint

```text
POST https://<host>:<port>/access/modiploc?ip=<ip>&lat=<lat>&long=<long>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `ip` | string | Yes | IPv4 or IPv6 address value used by the command. |
| `lat` | integer | Yes | Lat value for this command. |
| `long` | integer | Yes | Long value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/modiploc?ip=198.51.100.20&lat=example&long=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- modiploc operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/deliploc` — removes GEO IP range coordinates
