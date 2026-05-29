# access/listifconfig

**Category**: network  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Get-LmNetworkInterface`

## Description

Lists configured network interfaces and addressing information.

## Endpoint

```text
GET https://<host>:<port>/access/listifconfig
```

## HTTP Method

`GET` — read/query operation.

## Parameters

None — this is a read-only query.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/listifconfig"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- listifconfig fields -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This primitive is referenced by both the network and diagnostics categories because it is useful for both workflows.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/addvxlan` — adds VXLAN
- `access/delvxlan` — deletes VXLAN
- `access/addroute` — adds a static route to the appliance routing table
