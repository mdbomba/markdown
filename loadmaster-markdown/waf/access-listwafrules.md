# access/listwafrules

**Category**: WAF  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Get-WafRules`

## Description

Displays a list of all installed rules (commercial and custom rules).

## Endpoint

```text
GET https://<host>:<port>/access/listwafrules
```

## HTTP Method

`GET` — read/query operation.

## Parameters

None — this is a read-only query.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/listwafrules"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- listwafrules fields -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/downloadwafauditlog` — exports WAF audit log
- `access/listwafauditfiles` — retrieves WAF audit files
- `access/vslistwafruleids` — retrieves adc vs WAF rule
