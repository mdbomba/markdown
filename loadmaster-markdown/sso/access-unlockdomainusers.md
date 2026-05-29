# access/unlockdomainusers

**Category**: SSO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-SSODomainUnlockUser`

## Description

Unlocks one or more locked users for the specified SSO domain.

## Endpoint

```text
POST https://<host>:<port>/access/unlockdomainusers?users=<users>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `domain` | string | No | Domain name targeted by the command. |
| `domainid` | integer | No | Domainid identifier. |
| `users` | string | Yes | Users value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/unlockdomainusers?users=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- unlockdomainusers operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/ssodomain` — handles ssodomain
- `access/showdomainlockedusers` — lists currently locked users for the specified SSO domain
