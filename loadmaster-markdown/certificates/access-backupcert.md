# access/backupcert

**Category**: certificates  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Backup-TlsCertificate`

## Description

Downloads a certificate backup from the appliance.

## Endpoint

```text
GET https://<host>:<port>/access/backupcert?password=<password>[&...]
```

## HTTP Method

`GET` — read/query operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `password` | string | Yes | Password value associated with the command. |
| `path` | string | No | Local file path supplied to the PowerShell cmdlet; represented as uploaded or downloaded content in REST usage. |
| `force` | boolean | No | Force value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/backupcert?password=SecretPass!" -o backupcert.out
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- backupcert fields -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Certificate and licensing workflows can take noticeably longer than simple queries. A client timeout of `max_time=60` is recommended.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/listcert` — lists certificates stored on the appliance
- `access/readcert` — retrieves the details or contents of a stored certificate
- `access/restorecert` — restores a certificate backup onto the appliance
