# access/modlimitrule

**Category**: rate limiting  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-AdcLimitRule`

## Description

Updates adc limit rule.

## Endpoint

```text
POST https://<host>:<port>/access/modlimitrule?name=<name>&pattern=<pattern>&limit=<limit>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Object name used by the command. |
| `pattern` | string | Yes | Pattern value for this command. |
| `limit` | integer | Yes | Limit value for this command. |
| `match` | integer | Yes | Match value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/modlimitrule?name=example-name&pattern=example&limit=example&match=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- modlimitrule operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/addlimitrule` — creates adc limit rule
- `access/dellimitrule` — removes adc limit rule
