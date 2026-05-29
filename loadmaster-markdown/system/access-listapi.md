# access/listapi

**Category**: system  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Lists the REST primitives currently exposed by the appliance firmware build.

## Endpoint

```text
GET https://<host>:<port>/access/listapi
```

## HTTP Method

`GET` — read/query operation.

## Parameters

None — this is a read-only query.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/listapi"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- listapi fields -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/vstotals` — returns aggregate totals across configured virtual services
- `access/setadminaccess` — controls which source addresses are permitted to reach the administrative interface
- `access/addaddon` — installs lm addon
