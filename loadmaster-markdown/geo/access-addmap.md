# access/addmap

**Category**: GEO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `New-GeoFQDNSiteAddress`

## Description

Creates GEO FQDN site address.

## Endpoint

```text
POST https://<host>:<port>/access/addmap?fqdn=<fqdn>&IP=<IP>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `fqdn` | string | Yes | Fully qualified domain name handled by the command. |
| `IP` | string | Yes | IPv4 or IPv6 address value used by the command. |
| `clust` | string | No | Cluster name or cluster identifier. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/addmap?fqdn=app.example.com&IP=198.51.100.20"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- addmap operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/modmap` — updates GEO FQDN site address
- `access/delmap` — removes GEO FQDN site address
