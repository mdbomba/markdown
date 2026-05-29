# access/delrequestrule

**Category**: rules  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Deletes requestrule.

## Endpoint

```text
POST https://<host>:<port>/access/delrequestrule?vs=<vs>&rule=<rule>&port=<port>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `vs` | string | Yes | Virtual service IP address or internal virtual service identifier, depending on the command form. |
| `rule` | string | Yes | Rule name to show, add, modify, or remove. |
| `port` | integer | Yes | Virtual service port number. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/delrequestrule?vs=192.0.2.10&rule=example-rule&port=443"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- delrequestrule operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- The reference guide shows multiple endpoint forms for this command, including alternate addressing by ID or name where applicable.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/addrequestrule` — adds requestrule
