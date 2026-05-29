# access/groupsetperms

**Category**: users  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-SecRemoteUserGroup`

## Description

Updates sec remote user group.

## Endpoint

```text
POST https://<host>:<port>/access/groupsetperms?group=<group>&perms=<perms>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `group` | string | Yes | Remote group name. |
| `perms` | string | Yes | Permission set to assign to the user or group. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/groupsetperms?group=LoadMasterAdmins&perms=User Administration"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- groupsetperms operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/groupdelremote` — removes sec remote user group
- `access/grouplist` — handles grouplist
- `access/groupshow` — handles groupshow
