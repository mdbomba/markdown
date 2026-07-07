# access/logging.ping6

**Category**: system  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Forces a ping6 on an IPv6 address.

## Endpoint

```text
POST https://<host>:<port>/access/logging.ping6?addr=<addr>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `addr` | string | Yes | IPv6 address to ping. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/logging.ping6?addr=fd00::a01:9b0a"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- logging.ping6 fields -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"logging.ping6","addr":"10.0.0.50"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- The ping command returns a 200 OK success message even if an incorrect or non-existing interface is provided.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/logging.ping` — performs a ping (auto-detects IPv4/IPv6)
- `access/logging.traceroute` — performs a traceroute
