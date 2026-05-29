# access/modifycipherset

**Category**: certificates  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-TlsCipherSet`

## Description

Updates TLS cipher set.

## Endpoint

```text
POST https://<host>:<port>/access/modifycipherset?name=<name>&value=<value>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Object name used by the command. |
| `value` | string | Yes | New value to apply to the selected parameter. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/modifycipherset?name=example-name&value=enabled"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- modifycipherset operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Certificate and licensing workflows can take noticeably longer than simple queries. A client timeout of `max_time=60` is recommended.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/leaccountinfo` — retrieves leaccount info
- `access/getcipherset` — retrieves TLS cipher set
- `access/delcipherset` — can be used to delete an existing custom cipher set
