# access/updatedetect

**Category**: system  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Update-AFEIDSRules`

## Description

Checks whether newer software updates or patches are available for the appliance.

## Endpoint

```text
POST https://<host>:<port>/access/updatedetect?path=<path>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `path` | string | No | Local file path supplied to the PowerShell cmdlet; represented as uploaded or downloaded content in REST usage. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/updatedetect?path=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- updatedetect operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- The reference guide shows multiple endpoint forms for this command, including alternate addressing by ID or name where applicable.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/backup` — downloads a LoadMaster configuration backup bundle from the appliance
- `access/restore` — restores a previously exported LoadMaster configuration backup to the appliance
- `access/setmotd` — sets the message-of-the-day banner shown by the appliance
