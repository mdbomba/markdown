# access/kill_instance

**Category**: licensing extra  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Remove-Instance`

## Description

Removes a named instance registration from the licensing service.

## Endpoint

```text
POST https://<host>:<port>/access/kill_instance?kill=<kill>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `kill` | string | Yes | Required literal value `1`. Confirmation flag that must be set to `1` for destructive instance-removal operations. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/kill_instance?kill=1"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- kill instance operation completed -->
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
- `access/licenseinfo` — returns current appliance license details
