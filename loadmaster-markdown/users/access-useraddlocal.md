# access/useraddlocal

**Category**: users  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `New-SecUser`

## Description

Creates sec user.

## Endpoint

```text
POST https://<host>:<port>/access/useraddlocal?user=<user>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `user` | string | Yes | User name for the local or remote user entry. |
| `password` | string | No | Password value associated with the command. |
| `radius` | boolean | No | Radius value for this command. |
| `nopass` | string | No | Required literal value `yes`. Set to `yes` to create the account without an initial password. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/useraddlocal?user=apiuser"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- useraddlocal operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/userdellocal` — removes sec user
- `access/userlist` — retrieves sec user
