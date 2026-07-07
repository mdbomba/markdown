# access/ssodomain.search

**Category**: SSO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Filters the list of open sessions by user. The match is based on a substring of the username and is not exact. The `user` parameter is not case sensitive.

## Endpoint

```text
GET https://<host>:<port>/access/ssodomain.search?domain=<domain>&user=<user>
```

## HTTP Method

`GET` — read/query operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `domain` | string | Yes | SSO domain name to search. |
| `user` | string | Yes | Username substring to filter by (not case sensitive). |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/ssodomain.search?domain=example.com&user=ExampleUser"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- ssodomain.search fields -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"ssodomain.search","domain":"example.com","user":"ExampleUser"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/ssodomain.queryall` — lists all open sessions for a specific SSO domain
- `access/ssodomain.querysessions` — returns sessions within a particular range
- `access/ssodomain.killsession` — kills a specific SSO session
