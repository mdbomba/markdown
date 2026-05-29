# access/usernewcert

**Category**: users  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `New-SecUserCertificate`

## Description

Creates sec user certificate.

## Endpoint

```text
POST https://<host>:<port>/access/usernewcert?user=<user>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `user` | string | Yes | User name for the local or remote user entry. |
| `passphrase` | string | No | Passphrase value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/usernewcert?user=apiuser"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- usernewcert operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/usershow` — retrieves sec user
- `access/userchangelocpass` — updates sec user password
- `access/userreadcert` — handles userreadcert
