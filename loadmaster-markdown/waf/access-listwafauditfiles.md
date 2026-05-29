# access/listwafauditfiles

**Category**: WAF  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Get-WafAuditFiles`

## Description

Retrieves WAF audit files.

## Endpoint

```text
GET https://<host>:<port>/access/listwafauditfiles
```

## HTTP Method

`GET` — read/query operation.

## Parameters

None — this is a read-only query.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/listwafauditfiles"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- listwafauditfiles fields -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/maninstallwafrules` — installs WAF rules database
- `access/downloadwafauditlog` — exports WAF audit log
- `access/listwafrules` — displays a list of all installed rules (commercial and custom rules)
