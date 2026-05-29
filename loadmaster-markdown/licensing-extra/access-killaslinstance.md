# access/killaslinstance

**Category**: licensing extra  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Stop-AslInstance`

## Description

Stops the currently associated on-premise ASL licensing instance.

## Endpoint

```text
POST https://<host>:<port>/access/killaslinstance
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

None — this endpoint does not take query parameters in the documented form.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/killaslinstance"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- killaslinstance operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Certificate and licensing workflows can take noticeably longer than simple queries. A client timeout of `max_time=60` is recommended.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/kill_instance` — removes a named instance registration from the licensing service
- `access/licenseinfo` — returns current appliance license details
- `access/getaslinfo` — retrieves on-premise ASL licensing server details
