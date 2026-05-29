# access/getwafsettings

**Category**: WAF  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Get-WafRulesAutoUpdateConfiguration`

## Description

Retrieves WAF rules auto update configuration.

## Endpoint

```text
GET https://<host>:<port>/access/getwafsettings
```

## HTTP Method

`GET` — read/query operation.

## Parameters

None — this is a read-only query.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/getwafsettings"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- getwafsettings fields -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/setwafautoupdate` — sets wafautoupdate
- `access/downloadwafrules` — updates WAF rules database
- `access/addwafcustomrule` — creates WAF custom rule set
