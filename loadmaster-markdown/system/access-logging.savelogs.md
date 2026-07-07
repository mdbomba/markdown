# access/logging.savelogs

**Category**: system  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Saves all system log files, or a specific log file when the `fsel` parameter is provided. When using cURL from the command line, add the output parameter (for example, `--output` or `-o`).

## Endpoint

```text
GET https://<host>:<port>/access/logging.savelogs?fsel=<fsel>
```

## HTTP Method

`GET` — read/query operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `fsel` | string | No | Specific log file to save. If omitted, all system log files are saved. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/logging.savelogs?fsel=boot.msg"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- logging.savelogs fields -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"logging.savelogs","fsel":"messages"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- The legacy command before `savelogs` was `downloadlogs`.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/logging.listsyslogfiles` — lists the existing system log files
- `access/logging.clearlogs` — clears system log files
- `access/logging.saveextlogs` — saves extended log files
