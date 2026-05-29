# access/restorecert

**Category**: certificates  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Restore-TlsCertificate`

## Description

Restores a certificate backup onto the appliance.

## Endpoint

```text
POST https://<host>:<port>/access/restorecert?password=<password>&type=<type>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `password` | string | Yes | Password value associated with the command. |
| `path` | string | No | Local file path supplied to the PowerShell cmdlet; represented as uploaded or downloaded content in REST usage. |
| `type` | string | Yes | Type value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST --data-binary "@cert-backup.tar.gz" "https://10.0.0.69:443/access/restorecert?password=SecretPass!&type=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- restorecert operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Certificate and licensing workflows can take noticeably longer than simple queries. A client timeout of `max_time=60` is recommended.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/readcert` — retrieves the details or contents of a stored certificate
- `access/backupcert` — downloads a certificate backup from the appliance
- `access/addintermediate` — creates TLS intermediate certificate
