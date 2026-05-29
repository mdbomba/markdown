# access/getlecert

**Category**: certificates  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Retrieves details for a Let's Encrypt certificate.

## Endpoint

```text
GET https://<host>:<port>/access/getlecert?cert=<cert>
```

## HTTP Method

`GET` — read/query operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `cert` | string | Yes | Cert value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/getlecert?cert=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- getlecert fields -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Certificate and licensing workflows can take noticeably longer than simple queries. A client timeout of `max_time=60` is recommended.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/dellecert` — removes lecertificate
- `access/listlecert` — lists Let's Encrypt certificates known to the appliance
- `access/renewlecert` — requests renewal of an existing Let's Encrypt certificate
