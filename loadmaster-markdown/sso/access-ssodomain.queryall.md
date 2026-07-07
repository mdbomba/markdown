# access/ssodomain.queryall

**Category**: SSO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Retrieves a list of all open sessions for a specific SSO domain. Returns the number of active user and cookie sessions. SSO sessions for Basic Authentication, Client Certificate, and Form Based authentication types are counted as UserSessions. For Form Based authentication, the same session is also counted as a cookie session. SAML SSO sessions are counted as CookieSessions only.

## Endpoint

```text
GET https://<host>:<port>/access/ssodomain.queryall?domain=<domain>
```

## HTTP Method

`GET` — read/query operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `domain` | string | Yes | SSO domain name to query. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/ssodomain.queryall?domain=example.com"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- ssodomain.queryall fields -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"ssodomain.queryall","domain":"example.com"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/ssodomain.search` — filters the list of open sessions by user
- `access/ssodomain.querysessions` — returns sessions within a particular range
- `access/ssodomain.killallsessions` — kills all open sessions for a specific SSO domain
