# access/addrr

**Category**: GEO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `New-GeoFQDNResourceRecord`

## Description

Creates GEO FQDN resource record.

## Endpoint

```text
POST https://<host>:<port>/access/addrr?fqdn=<fqdn>&type=<type>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `fqdn` | string | Yes | Fully qualified domain name handled by the command. |
| `type` | string | Yes | Type value for this command. |
| `RData` | string | No | Rdata value for this command. |
| `Name` | string | No | Object name used by the command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/addrr?fqdn=app.example.com&type=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- addrr operation completed -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"addrr","fqdn":"example","type":"allow","RData":"example","Name":"example-name"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- The reference guide shows multiple endpoint forms for this command, including alternate addressing by ID or name where applicable.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/modrr` — updates GEO FQDN resource record
- `access/delrr` — removes GEO FQDN resource record
