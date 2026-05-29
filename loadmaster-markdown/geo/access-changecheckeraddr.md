# access/changecheckeraddr

**Category**: GEO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-GeoFQDNSiteCheckerAddress`

## Description

Updates GEO FQDN site checker address.

## Endpoint

```text
POST https://<host>:<port>/access/changecheckeraddr?fqdn=<fqdn>&IP=<IP>&checkerip=<checkerip>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `fqdn` | string | Yes | Fully qualified domain name handled by the command. |
| `IP` | string | Yes | IPv4 or IPv6 address value used by the command. |
| `checkerip` | string | Yes | Health checker source IP address to associate with the selected object. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/changecheckeraddr?fqdn=app.example.com&IP=198.51.100.20&checkerip=198.51.100.30"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- changecheckeraddr operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/removecountry` — removes GEO FQDN site country
- `access/geochangecheckermapping` — updates GEO FQDN site mapping
- `access/changemaploc` — updates GEO FQDN site coordinates
