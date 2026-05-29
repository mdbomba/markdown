# access/modrr

**Category**: GEO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-GeoFQDNResourceRecord`

## Description

Updates GEO FQDN resource record.

## Endpoint

```text
POST https://<host>:<port>/access/modrr?fqdn=<fqdn>&type=<type>&id=<id>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `fqdn` | string | Yes | Fully qualified domain name handled by the command. |
| `type` | string | Yes | Type value for this command. |
| `id` | integer | Yes | ID value for this command. |
| `param` | string | Yes | Name of the appliance parameter to read or update. |
| `value` | string | Yes | New value to apply to the selected parameter. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/modrr?fqdn=app.example.com&type=example&id=example&param=version"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- modrr operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- The reference guide shows multiple endpoint forms for this command, including alternate addressing by ID or name where applicable.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/addrr` — creates GEO FQDN resource record
- `access/delrr` — removes GEO FQDN resource record
