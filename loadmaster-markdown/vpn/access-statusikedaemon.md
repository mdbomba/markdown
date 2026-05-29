# access/statusikedaemon

**Category**: VPN  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Get-LmVpnIkeDaemonStatus`

## Description

Retrieves lm VPN ike daemon status.

## Endpoint

```text
GET https://<host>:<port>/access/statusikedaemon
```

## HTTP Method

`GET` — read/query operation.

## Parameters

None — this is a read-only query.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/statusikedaemon"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- statusikedaemon fields -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/startikedaemon` — starts lm VPN ike daemon
- `access/stopikedaemon` — stops lm VPN ike daemon
