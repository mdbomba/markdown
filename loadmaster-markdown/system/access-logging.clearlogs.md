# access/logging.clearlogs

**Category**: system  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Clears all system log files, or a specific log file when the `fsel` parameter is provided.

## Endpoint

```text
POST https://<host>:<port>/access/logging.clearlogs?fsel=<fsel>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `fsel` | string | No | Specific log file to clear. If omitted, all system log files are cleared. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/logging.clearlogs?fsel=check_addons_nodel"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- logging.clearlogs operation completed -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"logging.clearlogs","fsel":"messages"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- The legacy command before `clearlogs` was `resetlogs`.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/logging.listsyslogfiles` — lists the existing system log files
- `access/logging.savelogs` — saves system log files
- `access/logging.clearextlogs` — clears extended log files
