# access/ssodomain.querysessions

**Category**: SSO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Returns sessions within a particular range, as they appear in the cache. If `startsession` and `endsession` are not specified, the first 1000 sessions are returned. The maximum number of SSO sessions that can be returned in a single call is limited to 1000; use multiple calls if the total exceeds this.

## Endpoint

```text
GET https://<host>:<port>/access/ssodomain.querysessions?domain=<domain>&startsession=<startsession>&endsession=<endsession>
```

## HTTP Method

`GET` — read/query operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `domain` | string | Yes | SSO domain name to query. |
| `startsession` | integer | No | Starting session number (default: 1). |
| `endsession` | integer | No | Ending session number (default: 1000). |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/ssodomain.querysessions?domain=example.com&startsession=1&endsession=1000"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- ssodomain.querysessions fields -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"ssodomain.querysessions","domain":"example.com","startsession":"1","endsession":"1"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/ssodomain.queryall` — lists all open sessions for a specific SSO domain
- `access/ssodomain.search` — filters the list of open sessions by user
- `access/ssodomain.killsession` — kills a specific SSO session
