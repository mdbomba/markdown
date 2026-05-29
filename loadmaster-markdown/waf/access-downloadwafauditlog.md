# access/downloadwafauditlog

**Category**: WAF  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Export-WafAuditLog`

## Description

Exports WAF audit log.

## Endpoint

```text
GET https://<host>:<port>/access/downloadwafauditlog?filter=<filter>&force=<force>
```

## HTTP Method

`GET` — read/query operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `filter` | string | No | Filter expression used to reduce the returned data set. |
| `force` | boolean | No | Force value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/downloadwafauditlog?filter=active&force=example" -o downloadwafauditlog.out
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- downloadwafauditlog fields -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/setwafinstalltime` — sets wafinstalltime
- `access/maninstallwafrules` — installs WAF rules database
- `access/listwafauditfiles` — retrieves WAF audit files
