# access/restore

**Category**: system  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Restore-LmConfiguration`

## Description

Restores a previously exported LoadMaster configuration backup to the appliance.

## Endpoint

```text
POST https://<host>:<port>/access/restore?path=<path>&type=<type>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `path` | string | Yes | Local file path supplied to the PowerShell cmdlet; represented as uploaded or downloaded content in REST usage. |
| `type` | string | Yes | Type value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/restore?path=example&type=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- restore operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/shutdown` — handles shutdown
- `access/backup` — downloads a LoadMaster configuration backup bundle from the appliance
- `access/updatedetect` — checks whether newer software updates or patches are available for the appliance
