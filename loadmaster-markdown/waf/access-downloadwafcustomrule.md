# access/downloadwafcustomrule

**Category**: WAF  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Export-WafCustomRuleSet`

## Description

Exports WAF custom rule set.

## Endpoint

```text
GET https://<host>:<port>/access/downloadwafcustomrule?force=<force>
```

## HTTP Method

`GET` — read/query operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `force` | boolean | No | Force value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/downloadwafcustomrule?force=example" -o downloadwafcustomrule.out
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- downloadwafcustomrule fields -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- The reference guide shows multiple endpoint forms for this command, including alternate addressing by ID or name where applicable.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/addwafcustomrule` — creates WAF custom rule set
- `access/delwafcustomrule` — handles WAF custom rule set
- `access/addwafcustomdata` — creates WAF custom rule data
