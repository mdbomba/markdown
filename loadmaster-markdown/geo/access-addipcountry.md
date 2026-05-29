# access/addipcountry

**Category**: GEO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-GeoIPRangeCustomLocation`

## Description

Updates GEO IP range custom location.

## Endpoint

```text
POST https://<host>:<port>/access/addipcountry?ip=<ip>&customloc=<customloc>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `ip` | string | Yes | IPv4 or IPv6 address value used by the command. |
| `customloc` | string | Yes | Customloc value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/addipcountry?ip=198.51.100.20&customloc=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- addipcountry operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/modiploc` — updates GEO IP range coordinates
- `access/deliploc` — removes GEO IP range coordinates
- `access/removeipcountry` — removes GEO IP range country
