# access/logging.isextesplogenabled

**Category**: system  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Checks if the local extended ESP logs option is currently enabled. If disabled, no messages are written to the extended ESP logs and messages are only sent to the remote logger (if one is defined). If a remote logger is not defined, no logs are recorded.

## Endpoint

```text
GET https://<host>:<port>/access/logging.isextesplogenabled
```

## HTTP Method

`GET` — read/query operation.

## Parameters

None — this is a read-only query.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/logging.isextesplogenabled"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- logging.isextesplogenabled fields -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"logging.isextesplogenabled"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/logging.enableextesplog` — enables extended ESP logging
- `access/logging.disableextesplog` — disables extended ESP logging
- `access/logging.listextlogfiles` — lists the existing extended log files
