# access/enablewafremotelogging

**Category**: WAF  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Enable-WafRemoteLogging`

## Description

Enables WAF remote logging.

## Endpoint

```text
POST https://<host>:<port>/access/enablewafremotelogging?remoteuri=<remoteuri>&username=<username>&passwd=<passwd>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `remoteuri` | string | Yes | Remoteuri value for this command. |
| `username` | string | Yes | Username value for this command. |
| `passwd` | string | Yes | Password value associated with the command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/enablewafremotelogging?remoteuri=example&username=example&passwd=SecretPass!"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- enablewafremotelogging operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/disablewafremotelogging` — disables WAF remote logging
