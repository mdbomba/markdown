# access/createbond

**Category**: network  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Register-NetworkBondedInterface`

## Description

Registers network bonded interface.

## Endpoint

```text
POST https://<host>:<port>/access/createbond?iface=<iface>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `iface` | integer | Yes | Network interface identifier. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/createbond?iface=1"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- createbond operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/addadditional` — adds additional
- `access/deladditional` — deletes additional
- `access/unbond` — handles network bonded interface
