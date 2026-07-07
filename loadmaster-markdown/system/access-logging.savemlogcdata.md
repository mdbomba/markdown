# access/logging.savemlogcdata

**Category**: system  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Saves temporary WAF remote log data to the local machine.

## Endpoint

```text
GET https://<host>:<port>/access/logging.savemlogcdata
```

## HTTP Method

`GET` — read/query operation.

## Parameters

None — this is a read-only query.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/logging.savemlogcdata"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- logging.savemlogcdata fields -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"logging.savemlogcdata"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/logging.clearmlogcdata` — clears temporary WAF remote log data
- `access/enablewafremotelogging` — enables WAF remote logging
- `access/disablewafremotelogging` — disables WAF remote logging
