# access/addldapendpoint

**Category**: LDAP  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `New-LdapEndpoint`

## Description

Creates LDAP endpoint.

## Endpoint

```text
POST https://<host>:<port>/access/addldapendpoint?name=<name>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Object name used by the command. |
| `server` | string | No | Server value for this command. |
| `ldapprotocol` | string | No | Ldapprotocol value for this command. |
| `vinterval` | integer | No | Vinterval value for this command. |
| `referralcount` | integer | No | Referralcount value for this command. |
| `timeout` | integer | No | Timeout value in seconds. |
| `adminuser` | string | No | Adminuser value for this command. |
| `adminpass` | string | No | Adminpass value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/addldapendpoint?name=example-name"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- addldapendpoint operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/showldapendpoint` — shows ldapendpoint
