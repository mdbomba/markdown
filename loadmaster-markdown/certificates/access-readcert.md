# access/readcert

**Category**: certificates  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Get-TlsCertificate`

## Description

Retrieves the details or contents of a stored certificate.

## Endpoint

```text
GET https://<host>:<port>/access/readcert?cert=<cert>&outform=<outform>
```

## HTTP Method

`GET` — read/query operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `cert` | string | Yes | Cert value for this command. |
| `outform` | string | Yes | Outform value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/readcert?cert=example&outform=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- readcert fields -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- The reference guide shows multiple endpoint forms for this command, including alternate addressing by ID or name where applicable.
- Certificate and licensing workflows can take noticeably longer than simple queries. A client timeout of `max_time=60` is recommended.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/delcert` — removes TLS certificate
- `access/listcert` — lists certificates stored on the appliance
- `access/backupcert` — downloads a certificate backup from the appliance
