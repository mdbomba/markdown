# access/license

**Category**: licensing extra  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Update-LicenseOffline`

## Description

Uploads an offline license request or response file to the appliance.

## Endpoint

```text
POST https://<host>:<port>/access/license?path=<path>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `path` | string | Yes | Local file path supplied to the PowerShell cmdlet; represented as uploaded or downloaded content in REST usage. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST --data-binary "@license-response.bin" "https://10.0.0.69:443/access/license?path=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- license operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Certificate and licensing workflows can take noticeably longer than simple queries. A client timeout of `max_time=60` is recommended.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/spla_license` — runs the SPLA licensing workflow against Progress licensing services
- `access/kill_spla_instance` — removes a SPLA instance registration from the licensing service
