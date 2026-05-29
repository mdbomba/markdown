# access/clientcpslimitlist

**Category**: rate limiting  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Get-ClientCPSLimit`

## Description

Retrieves client cpslimit.

## Endpoint

```text
POST https://<host>:<port>/access/clientcpslimitlist
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

None — this endpoint does not take query parameters in the documented form.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/clientcpslimitlist"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- clientcpslimitlist operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/clientcpslimitadd` — creates client cpslimit
- `access/clientcpslimitdel` — removes client cpslimit
- `access/clientmaxclimitadd` — creates client maxc limit
