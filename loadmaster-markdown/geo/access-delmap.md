# access/delmap

**Category**: GEO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Remove-GeoFQDNSiteAddress`

## Description

Removes GEO FQDN site address.

## Endpoint

```text
POST https://<host>:<port>/access/delmap?fqdn=<fqdn>&IP=<IP>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `fqdn` | string | Yes | Fully qualified domain name handled by the command. |
| `IP` | string | Yes | IPv4 or IPv6 address value used by the command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/delmap?fqdn=app.example.com&IP=198.51.100.20"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- delmap operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/addmap` — creates GEO FQDN site address
