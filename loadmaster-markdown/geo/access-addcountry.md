# access/addcountry

**Category**: GEO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-GeoFQDNSiteCountry`

## Description

Updates GEO FQDN site country.

## Endpoint

```text
POST https://<host>:<port>/access/addcountry?fqdn=<fqdn>&IP=<IP>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `fqdn` | string | Yes | Fully qualified domain name handled by the command. |
| `IP` | string | Yes | IPv4 or IPv6 address value used by the command. |
| `countrycode` | string | No | Countrycode value for this command. |
| `iscontinent` | string | No | Iscontinent flag. |
| `customlocation` | string | No | Customlocation value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/addcountry?fqdn=app.example.com&IP=198.51.100.20"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- addcountry operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- The reference guide shows multiple endpoint forms for this command, including alternate addressing by ID or name where applicable.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/addipcountry` — updates GEO IP range custom location
- `access/removeipcountry` — removes GEO IP range country
- `access/removecountry` — removes GEO FQDN site country
