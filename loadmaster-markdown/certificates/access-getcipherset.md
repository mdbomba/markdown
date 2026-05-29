# access/getcipherset

**Category**: certificates  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Get-TlsCipherSet`

## Description

Retrieves TLS cipher set.

## Endpoint

```text
GET https://<host>:<port>/access/getcipherset?name=<name>
```

## HTTP Method

`GET` — read/query operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Object name used by the command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/getcipherset?name=example-name"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- getcipherset fields -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Certificate and licensing workflows can take noticeably longer than simple queries. A client timeout of `max_time=60` is recommended.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/fetchleaccount` — retrieves stored Let's Encrypt account details
- `access/leaccountinfo` — retrieves leaccount info
- `access/modifycipherset` — updates TLS cipher set
