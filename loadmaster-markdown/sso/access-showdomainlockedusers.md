# access/showdomainlockedusers

**Category**: SSO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Get-SSODomainLockedUser`

## Description

Lists currently locked users for the specified SSO domain.

## Endpoint

```text
GET https://<host>:<port>/access/showdomainlockedusers?domain=<domain>
```

## HTTP Method

`GET` — read/query operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `domain` | string | No | Domain name targeted by the command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/showdomainlockedusers?domain=example.com"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- showdomainlockedusers fields -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/listssoimages` — lists ssoimages
- `access/ssodomain` — handles ssodomain
- `access/unlockdomainusers` — unlocks one or more locked users for the specified SSO domain
