# access/ssodomain

**Category**: SSO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Handles ssodomain.

## Endpoint

```text
POST https://<host>:<port>/access/ssodomain?domain=<domain>&key=<key>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `domain` | string | Yes | Domain name targeted by the command. |
| `key` | string | Yes | API key value to list or delete. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/ssodomain?domain=example.com&key=0123456789abcdef"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- ssodomain operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- The reference guide shows multiple endpoint forms for this command, including alternate addressing by ID or name where applicable.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/delssoimage` — deletes ssoimage
- `access/listssoimages` — lists ssoimages
- `access/showdomainlockedusers` — lists currently locked users for the specified SSO domain
