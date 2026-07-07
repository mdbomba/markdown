# access/delrr

**Category**: GEO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Remove-GeoFQDNResourceRecord`

## Description

Removes GEO FQDN resource record.

## Endpoint

```text
POST https://<host>:<port>/access/delrr?fqdn=<fqdn>&id=<id>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `fqdn` | string | Yes | Fully qualified domain name handled by the command. |
| `id` | integer | Yes | ID value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/delrr?fqdn=app.example.com&id=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- delrr operation completed -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"delrr","fqdn":"example","id":"1"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/addrr` — creates GEO FQDN resource record
