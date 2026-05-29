# access/addbond

**Category**: network  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `New-NetworkBondedInterface`

## Description

Creates network bonded interface.

## Endpoint

```text
POST https://<host>:<port>/access/addbond?iface=<iface>&bondid=<bondid>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `iface` | integer | Yes | Network interface identifier. |
| `bondid` | integer | Yes | Bondid identifier. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/addbond?iface=1&bondid=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- addbond operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/delbond` — removes network bonded interface
