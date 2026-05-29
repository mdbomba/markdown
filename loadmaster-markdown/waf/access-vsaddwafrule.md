# access/vsaddwafrule

**Category**: WAF  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `New-AdcVsWafRule`

## Description

Creates adc vs WAF rule.

## Endpoint

```text
POST https://<host>:<port>/access/vsaddwafrule?vs=<vs>&port=<port>&prot=<prot>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `vs` | string | Yes | Virtual service IP address or internal virtual service identifier, depending on the command form. |
| `port` | string | Yes | Virtual service port number. |
| `prot` | string | Yes | Virtual service protocol, typically `tcp` or `udp`. |
| `rule` | string | Yes | Rule name to show, add, modify, or remove. |
| `enablerules` | string | No | Enablerules flag. |
| `disablerules` | string | No | Disablerules flag. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/vsaddwafrule?vs=192.0.2.10&port=443&prot=tcp&rule=example-rule"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- vsaddwafrule operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- The reference guide shows multiple endpoint forms for this command, including alternate addressing by ID or name where applicable.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/listwafrules` — displays a list of all installed rules (commercial and custom rules)
- `access/vslistwafruleids` — retrieves adc vs WAF rule
- `access/vsremovewafrule` — removes adc vs WAF rule
