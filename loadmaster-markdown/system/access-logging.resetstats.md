# access/logging.resetstats

**Category**: system  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Resets the statistics.

## Endpoint

```text
POST https://<host>:<port>/access/logging.resetstats
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

None — this command takes no parameters.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/logging.resetstats"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- logging.resetstats operation completed -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"logging.resetstats"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/stats` — returns current appliance traffic and usage statistics
- `access/logging.top` — performs a top command
- `access/logging.meminfo` — retrieves memory information
