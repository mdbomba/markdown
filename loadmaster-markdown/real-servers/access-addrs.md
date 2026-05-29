# access/addrs

**Category**: real servers  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `New-AdcRealServer`

## Description

Adds a real server to a virtual service.

## Endpoint

```text
POST https://<host>:<port>/access/addrs?rs=<rs>&rsport=<rsport>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `vs` | string | No | Virtual service IP address or internal virtual service identifier, depending on the command form. |
| `port` | integer | No | Virtual service port number. |
| `prot` | string | No | Virtual service protocol, typically `tcp` or `udp`. |
| `rs` | string | Yes | Real server IP address or internal real server identifier. |
| `rsport` | integer | Yes | Real server listening port. |
| `weight` | integer | No | Weight value for this command. |
| `forward` | string | No | Forward value for this command. |
| `enable` | boolean | No | Boolean-style enable flag used by the endpoint. |
| `non_local` | boolean | No | Non Local value for this command. |
| `limit` | integer | No | Limit value for this command. |
| `ratelimit` | integer | No | Ratelimit value for this command. |
| `critical` | boolean | No | Critical value for this command. |
| `addtoallsubvs` | boolean | No | Addtoallsubvs value for this command. |
| `follow` | integer | No | Follow value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/addrs?rs=192.0.2.21&rsport=443"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- addrs operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/modrs` — modifies the settings of a real server
- `access/delrs` — deletes a real server from a virtual service
- `access/showrs` — retrieves details for one real server attached to a virtual service
