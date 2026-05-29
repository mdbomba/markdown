# access/vstotals

**Category**: system  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Get-AdcTotalVirtualService`

## Description

Returns aggregate totals across configured virtual services.

## Endpoint

```text
GET https://<host>:<port>/access/vstotals
```

## HTTP Method

`GET` — read/query operation.

## Parameters

None — this is a read-only query.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/vstotals"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- vstotals fields -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/logging` — retrieves logging statistics or downloads logging-related diagnostic artifacts, depending on the request parameters
- `access/stats` — returns current appliance traffic and usage statistics
- `access/setadminaccess` — controls which source addresses are permitted to reach the administrative interface
