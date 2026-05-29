# access/modrs

**Category**: real servers  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-AdcRealServer`

## Description

Modifies the settings of a real server.

## Endpoint

```text
POST https://<host>:<port>/access/modrs?vs=<vs>&port=<port>&prot=<prot>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `vs` | string | No | Virtual service IP address or internal virtual service identifier, depending on the command form. |
| `port` | integer | No | Virtual service port number. |
| `prot` | string | No | Virtual service protocol, typically `tcp` or `udp`. |
| `rs` | string | No | Real server IP address or internal real server identifier. |
| `rsport` | integer | No | Real server listening port. |
| `newport` | integer | No | Newport port number. |
| `weight` | integer | No | Weight value for this command. |
| `forward` | string | No | Forward value for this command. |
| `enable` | boolean | No | Boolean-style enable flag used by the endpoint. |
| `limit` | integer | No | Limit value for this command. |
| `ratelimit` | integer | No | Ratelimit value for this command. |
| `critical` | boolean | No | Critical value for this command. |
| `follow` | integer | No | Follow value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/modrs?vs=192.0.2.10&port=443&prot=tcp"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- modrs operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- The reference guide shows multiple endpoint forms for this command, including alternate addressing by ID or name where applicable.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/showrs` — retrieves details for one real server attached to a virtual service
- `access/addrs` — adds a real server to a virtual service
- `access/delrs` — deletes a real server from a virtual service
