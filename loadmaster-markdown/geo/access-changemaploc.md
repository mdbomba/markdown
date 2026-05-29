# access/changemaploc

**Category**: GEO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-GeoFQDNSiteCoordinates`

## Description

Updates GEO FQDN site coordinates.

## Endpoint

```text
POST https://<host>:<port>/access/changemaploc?fqdn=<fqdn>&IP=<IP>&lat=<lat>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `fqdn` | string | Yes | Fully qualified domain name handled by the command. |
| `IP` | string | Yes | IPv4 or IPv6 address value used by the command. |
| `lat` | integer | Yes | Lat value for this command. |
| `long` | integer | Yes | Long value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/changemaploc?fqdn=app.example.com&IP=198.51.100.20&lat=example&long=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- changemaploc operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/geochangecheckermapping` — updates GEO FQDN site mapping
- `access/changecheckeraddr` — updates GEO FQDN site checker address
- `access/listclusters` — lists clusters
