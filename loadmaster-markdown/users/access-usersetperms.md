# access/usersetperms

**Category**: users  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-SecUserPermission`

## Description

Updates sec user permission.

## Endpoint

```text
POST https://<host>:<port>/access/usersetperms?user=<user>&perms=<perms>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `user` | string | Yes | User name for the local or remote user entry. |
| `perms` | string | Yes | Permission set to assign to the user or group. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/usersetperms?user=apiuser&perms=User Administration"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- usersetperms operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- The reference guide shows multiple endpoint forms for this command, including alternate addressing by ID or name where applicable.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/userdelcert` — removes sec user certificate
- `access/userdownloadcert` — exports sec user certificate
- `access/usersetsyspassword` — updates sec system user password
