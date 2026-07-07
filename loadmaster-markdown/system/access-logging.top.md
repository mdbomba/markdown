# access/logging.top

**Category**: system  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Performs a top command to display running processes and resource usage.

## Endpoint

```text
GET https://<host>:<port>/access/logging.top?iterations=<iterations>&interval=<interval>&threads=<threads>&mem=<mem>
```

## HTTP Method

`GET` — read/query operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `iterations` | integer | No | Number of samples (default 10). Range: 1-30. |
| `interval` | integer | No | Interval between samples in seconds (default 1). Range: 1-30. |
| `threads` | boolean | No | Show process threads (disabled by default). 0 = Disabled, 1 = Enabled. |
| `mem` | boolean | No | Sort by memory usage instead of CPU (default 0). 0 = Disabled, 1 = Enabled. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/logging.top?iterations=4&interval=3&threads=1&mem=1"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- logging.top fields -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"logging.top","iterations":"10","interval":"1","threads":"1","mem":"1"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/logging.meminfo` — retrieves memory information
- `access/stats` — returns current appliance traffic and usage statistics
- `access/logging.resetstats` — resets statistics
