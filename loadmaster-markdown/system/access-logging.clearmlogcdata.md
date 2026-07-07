# access/logging.clearmlogcdata

**Category**: system  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Clears temporary WAF remote log data. This data is created when WAF remote logging is enabled and the remote log server is down or too slow to process the amount of logs generated. These log files are temporary and get automatically deleted once the data has been sent to the remote log server.

## Endpoint

```text
POST https://<host>:<port>/access/logging.clearmlogcdata
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

None — this command takes no parameters.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/logging.clearmlogcdata"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- logging.clearmlogcdata operation completed -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"logging.clearmlogcdata"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/logging.savemlogcdata` — saves temporary WAF remote log data
- `access/enablewafremotelogging` — enables WAF remote logging
- `access/disablewafremotelogging` — disables WAF remote logging
