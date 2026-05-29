# access/licenseinfo

**Category**: licensing extra  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Get-LicenseInfo`

## Description

Returns current appliance license details.

## Endpoint

```text
GET https://<host>:<port>/access/licenseinfo
```

## HTTP Method

`GET` — read/query operation.

## Parameters

None — this is a read-only query.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/licenseinfo"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- licenseinfo fields -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Certificate and licensing workflows can take noticeably longer than simple queries. A client timeout of `max_time=60` is recommended.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/kill_spla_instance` — removes a SPLA instance registration from the licensing service
- `access/kill_instance` — removes a named instance registration from the licensing service
- `access/killaslinstance` — stops the currently associated on-premise ASL licensing instance
