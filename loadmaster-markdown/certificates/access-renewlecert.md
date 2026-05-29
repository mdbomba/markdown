# access/renewlecert

**Category**: certificates  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Request-RenewLECertificate`

## Description

Requests renewal of an existing Let's Encrypt certificate.

## Endpoint

```text
POST https://<host>:<port>/access/renewlecert?cert=<cert>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `cert` | string | Yes | Cert value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/renewlecert?cert=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- renewlecert operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Certificate and licensing workflows can take noticeably longer than simple queries. A client timeout of `max_time=60` is recommended.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/listlecert` — lists Let's Encrypt certificates known to the appliance
- `access/getlecert` — retrieves details for a Let's Encrypt certificate
- `access/registerleaccount` — registers a Let's Encrypt account for certificate automation
