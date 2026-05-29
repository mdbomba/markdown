# access/delresponsebodyrule

**Category**: rules  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Remove-AdcVirtualServiceResponseBodyRule`

## Description

Removes adc virtual service response body rule.

## Endpoint

```text
POST https://<host>:<port>/access/delresponsebodyrule?vs=<vs>&rule=<rule>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `vs` | integer | Yes | Virtual service IP address or internal virtual service identifier, depending on the command form. |
| `rule` | string | Yes | Rule name to show, add, modify, or remove. |
| `force` | boolean | No | Force value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/delresponsebodyrule?vs=192.0.2.10&rule=example-rule"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- delresponsebodyrule operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/addresponsebodyrule` — creates adc virtual service response body rule
