# access/showrs

**Category**: real servers  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Retrieves details for one real server attached to a virtual service.

## Endpoint

```text
GET https://<host>:<port>/access/showrs?vs=<vs>&port=<port>&prot=<prot>[&...]
```

## HTTP Method

`GET` — read/query operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `vs` | string | Yes | Virtual service IP address or internal virtual service identifier, depending on the command form. |
| `port` | integer | Yes | Virtual service port number. |
| `prot` | string | Yes | Virtual service protocol, typically `tcp` or `udp`. |
| `rs` | string | Yes | Real server IP address or internal real server identifier. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/showrs?vs=192.0.2.10&port=443&prot=tcp&rs=192.0.2.21"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- showrs fields -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/modrs` — modifies the settings of a real server
