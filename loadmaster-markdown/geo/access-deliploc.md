# access/deliploc

**Category**: GEO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Remove-GeoIPRangeCoordinates`

## Description

Removes GEO IP range coordinates.

## Endpoint

```text
POST https://<host>:<port>/access/deliploc?ip=<ip>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `ip` | string | Yes | IPv4 or IPv6 address value used by the command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/deliploc?ip=198.51.100.20"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- deliploc operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/delip` — removes GEO IP range
- `access/modiploc` — updates GEO IP range coordinates
- `access/addipcountry` — updates GEO IP range custom location
