# access/modrule

**Category**: rules  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-AdcContentRule`

## Description

Updates adc content rule.

## Endpoint

```text
POST https://<host>:<port>/access/modrule?matchtype=<matchtype>&inchost=<inchost>&nocase=<nocase>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `matchtype` | string | No | Matchtype value for this command. |
| `inchost` | boolean | No | Inchost host value. |
| `nocase` | boolean | No | Nocase value for this command. |
| `negate` | boolean | No | Negate value for this command. |
| `incquery` | boolean | No | Incquery value for this command. |
| `header` | string | No | Header value for this command. |
| `pattern` | string | No | Pattern value for this command. |
| `replacement` | string | No | Replacement value for this command. |
| `type` | integer | No | Type value for this command. |
| `onlyonnoflag` | integer | No | Onlyonnoflag value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/modrule?matchtype=example&inchost=example&nocase=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- modrule operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/showrule` — with no parameters will list all of the existing rules
- `access/addrule` — creates adc content rule
- `access/delrule` — removes adc content rule
