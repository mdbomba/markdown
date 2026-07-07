# access/ssodomain.killsession

**Category**: SSO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Kills a particular SSO session. For the `key` parameter, specify either the cookie value or a `Username,SourceIPAddress` pair.

## Endpoint

```text
POST https://<host>:<port>/access/ssodomain.killsession?domain=<domain>&key=<key>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `domain` | string | Yes | SSO domain name. |
| `key` | string | Yes | Cookie value or `Username,SourceIPAddress` pair identifying the session. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/ssodomain.killsession?domain=example.com&key=0123456789abcdef"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- ssodomain.killsession operation completed -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"ssodomain.killsession","domain":"example.com","key":"0123456789abcdef"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/ssodomain.killallsessions` — kills all open sessions for a specific SSO domain
- `access/ssodomain.queryall` — lists all open sessions for a specific SSO domain
- `access/ssodomain.search` — filters the list of open sessions by user
