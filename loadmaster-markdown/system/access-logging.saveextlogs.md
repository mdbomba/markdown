# access/logging.saveextlogs

**Category**: system  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Saves the extended log files. To save all non-rotated log files, omit the `fsel` parameter. When using cURL from the command line, add the output parameter (for example, `--output` or `-o`).

## Endpoint

```text
GET https://<host>:<port>/access/logging.saveextlogs?fsel=<fsel>
```

## HTTP Method

`GET` — read/query operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `fsel` | string | No | Specific extended log file to save. If omitted, all non-rotated log files are saved. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/logging.saveextlogs?fsel=wafaudit.1"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- logging.saveextlogs fields -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"logging.saveextlogs","fsel":"messages"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/logging.listextlogfiles` — lists the existing extended log files
- `access/logging.clearextlogs` — clears extended log files
- `access/logging.savelogs` — saves system log files
