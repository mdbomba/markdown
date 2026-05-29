# access/userchangelocpass

**Category**: users  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-SecUserPassword`

## Description

Updates sec user password.

## Endpoint

```text
POST https://<host>:<port>/access/userchangelocpass?user=<user>&password=<password>&radius=<radius>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `user` | string | Yes | User name for the local or remote user entry. |
| `password` | string | Yes | Password value associated with the command. |
| `radius` | integer | Yes | Radius value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/userchangelocpass?user=apiuser&password=SecretPass!&radius=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- userchangelocpass operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/userlist` — retrieves sec user
- `access/usershow` — retrieves sec user
- `access/usernewcert` — creates sec user certificate
