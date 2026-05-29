# access/addcert

**Category**: certificates  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `New-TlsCertificate`

## Description

Uploads a certificate bundle to the appliance certificate store.

## Endpoint

```text
POST https://<host>:<port>/access/addcert?name=<name>&path=<path>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Object name used by the command. |
| `password` | string | No | Password value associated with the command. |
| `replace` | boolean | No | Set to replace an existing stored object with the same name. |
| `path` | string | Yes | Local file path supplied to the PowerShell cmdlet; represented as uploaded or downloaded content in REST usage. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST --data-binary "@server-cert.pem" "https://10.0.0.69:443/access/addcert?name=example-name&path=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- addcert operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Certificate and licensing workflows can take noticeably longer than simple queries. A client timeout of `max_time=60` is recommended.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/delcert` — removes TLS certificate
- `access/listcert` — lists certificates stored on the appliance
