# access/logging.clearextlogs

**Category**: system  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Clears the extended log files.

## Endpoint

```text
POST https://<host>:<port>/access/logging.clearextlogs?fsel=<fsel>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `fsel` | string | No | Specific extended log file to clear. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/logging.clearextlogs?fsel=wafaudit.1"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- logging.clearextlogs operation completed -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"logging.clearextlogs","fsel":"messages"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/logging.listextlogfiles` — lists the existing extended log files
- `access/logging.saveextlogs` — saves extended log files
- `access/logging.clearlogs` — clears system log files
