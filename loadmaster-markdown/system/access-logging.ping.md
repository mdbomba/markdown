# access/logging.ping

**Category**: system  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Performs a ping. The LoadMaster tries to auto-detect what type of ping to use (ping for IPv4 and ping6 for IPv6).

## Endpoint

```text
POST https://<host>:<port>/access/logging.ping?addr=<addr>&intf=<intf>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `addr` | string | Yes | Host to perform the ping on. Accepts an IPv4 address, IPv6 address, FQDN, or hostname. |
| `intf` | integer | No | ID of the interface from which the ping should be sent. If not specified, the correct interface is automatically selected. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/logging.ping?addr=progress.com"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- logging.ping fields -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"logging.ping","addr":"10.0.0.50","intf":"1"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- The ping command returns a 200 OK success message even if an incorrect or non-existing interface is provided.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/logging.ping6` — performs a ping using IPv6
- `access/logging.traceroute` — performs a traceroute
