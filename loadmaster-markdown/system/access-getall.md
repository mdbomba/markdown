# access/getall

**Category**: system  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Get-LmAllParameters`

## Description

Returns the current values for LoadMaster runtime parameters in a single XML response.

## Endpoint

```text
GET https://<host>:<port>/access/getall
```

## HTTP Method

`GET` — read/query operation.

## Parameters

None — this is a read-only query.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/getall"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- getall fields -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- See `/home/chef/api_calls/params-reference.md` for commonly used parameter names and live values captured from the appliance.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/get` — retrieves the current value of a single LoadMaster runtime parameter by name
- `access/set` — updates a single LoadMaster runtime parameter to a supplied value
- `access/reboot` — handles reboot
