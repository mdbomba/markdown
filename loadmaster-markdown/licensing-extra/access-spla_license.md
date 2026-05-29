# access/spla_license

**Category**: licensing extra  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Runs the SPLA licensing workflow against Progress licensing services.

## Endpoint

```text
POST https://<host>:<port>/access/spla_license
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

None — this endpoint does not take query parameters in the documented form.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST --data-binary "@spla-license.bin" "https://10.0.0.69:443/access/spla_license"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- SPLA license operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Certificate and licensing workflows can take noticeably longer than simple queries. A client timeout of `max_time=60` is recommended.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/license` — uploads an offline license request or response file to the appliance
- `access/kill_spla_instance` — removes a SPLA instance registration from the licensing service
- `access/kill_instance` — removes a named instance registration from the licensing service
