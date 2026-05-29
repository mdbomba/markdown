# access/clientcpslimitdel

**Category**: rate limiting  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Remove-ClientCPSLimit`

## Description

Removes client cpslimit.

## Endpoint

```text
POST https://<host>:<port>/access/clientcpslimitdel?l7addr=<l7addr>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `l7addr` | string | Yes | L7addr IP address. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/clientcpslimitdel?l7addr=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- clientcpslimitdel operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/clientbandwidthlimitlist` — retrieves client bandwidth limit
- `access/clientcpslimitadd` — creates client cpslimit
- `access/clientcpslimitlist` — retrieves client cpslimit
