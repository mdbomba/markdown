# access/set

**Category**: system  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-LmBackupSecureIdentity`

## Description

Updates a single LoadMaster runtime parameter to a supplied value.

## Endpoint

```text
POST https://<host>:<port>/access/set?path=<path>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `path` | string | Yes | Local file path supplied to the PowerShell cmdlet; represented as uploaded or downloaded content in REST usage. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/set?path=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- set operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- See `/home/chef/api_calls/params-reference.md` for commonly used parameter names and live values captured from the appliance.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/get` — retrieves the current value of a single LoadMaster runtime parameter by name
- `access/getall` — returns the current values for LoadMaster runtime parameters in a single XML response
- `access/reboot` — handles reboot
