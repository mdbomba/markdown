# access/movelimitrule

**Category**: rate limiting  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Move-AdcLimitRule`

## Description

Handles adc limit rule.

## Endpoint

```text
POST https://<host>:<port>/access/movelimitrule?name=<name>&position=<position>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Object name used by the command. |
| `position` | integer | Yes | Position value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/movelimitrule?name=example-name&position=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- movelimitrule operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/dellimitrule` — removes adc limit rule
- `access/modlimitrule` — updates adc limit rule
- `access/listlimitrules` — retrieves adc limit rules
