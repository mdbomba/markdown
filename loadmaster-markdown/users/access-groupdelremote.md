# access/groupdelremote

**Category**: users  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Remove-SecRemoteUserGroup`

## Description

Removes sec remote user group.

## Endpoint

```text
POST https://<host>:<port>/access/groupdelremote?group=<group>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `group` | string | Yes | Remote group name. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/groupdelremote?group=LoadMasterAdmins"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- groupdelremote operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/usersetsyspassword` — updates sec system user password
- `access/groupaddremote` — creates sec remote user group
- `access/grouplist` — handles grouplist
