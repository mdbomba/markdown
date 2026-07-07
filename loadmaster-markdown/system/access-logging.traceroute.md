# access/logging.traceroute

**Category**: system  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Performs a traceroute. The `addr` parameter accepts an IPv4 address, IPv6 address, FQDN, or hostname.

## Endpoint

```text
POST https://<host>:<port>/access/logging.traceroute?addr=<addr>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `addr` | string | Yes | Destination address. Accepts an IPv4 address, IPv6 address, FQDN, or hostname. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/logging.traceroute?addr=progress.com"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- logging.traceroute fields -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"logging.traceroute","addr":"10.0.0.50"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/logging.ping` — performs a ping (auto-detects IPv4/IPv6)
- `access/logging.ping6` — performs a ping using IPv6
