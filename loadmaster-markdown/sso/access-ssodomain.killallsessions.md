# access/ssodomain.killallsessions

**Category**: SSO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Kills all open sessions for a particular SSO domain.

## Endpoint

```text
POST https://<host>:<port>/access/ssodomain.killallsessions?domain=<domain>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `domain` | string | Yes | SSO domain name. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/ssodomain.killallsessions?domain=example.com"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- ssodomain.killallsessions operation completed -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"ssodomain.killallsessions","domain":"example.com"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/ssodomain.killsession` — kills a specific SSO session
- `access/ssodomain.queryall` — lists all open sessions for a specific SSO domain
- `access/ssodomain.querysessions` — returns sessions within a particular range
