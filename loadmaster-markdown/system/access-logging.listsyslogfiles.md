# access/logging.listsyslogfiles

**Category**: system  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Lists the existing system log files.

## Endpoint

```text
GET https://<host>:<port>/access/logging.listsyslogfiles
```

## HTTP Method

`GET` — read/query operation.

## Parameters

None — this is a read-only query.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/logging.listsyslogfiles"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- logging.listsyslogfiles fields -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"logging.listsyslogfiles"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/logging.savelogs` — saves system log files
- `access/logging.clearlogs` — clears system log files
- `access/logging.listextlogfiles` — lists the extended log files
