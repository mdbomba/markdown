# access/geochangecheckermapping

**Category**: GEO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-GeoFQDNSiteMapping`

## Description

Updates GEO FQDN site mapping.

## Endpoint

```text
POST https://<host>:<port>/access/geochangecheckermapping?fqdn=<fqdn>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `fqdn` | string | Yes | Fully qualified domain name handled by the command. |
| `fqdnip` | string | No | Fqdnip IP address. |
| `remport` | string | No | Required literal value `2`. Remport port number. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/geochangecheckermapping?fqdn=app.example.com"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- geochangecheckermapping operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/addcountry` — updates GEO FQDN site country
- `access/removecountry` — removes GEO FQDN site country
- `access/changecheckeraddr` — updates GEO FQDN site checker address
