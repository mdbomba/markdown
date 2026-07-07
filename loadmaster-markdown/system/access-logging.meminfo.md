# access/logging.meminfo

**Category**: system  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Retrieves memory information. This is one of several debug option commands. Other related commands include `logging.ps`, `logging.ifconfig`, `listifconfig`, `logging.netstat`, `logging.interrupts`, `logging.partitions`, `logging.cpuinfo`, `logging.df`, `logging.lspci`, `logging.lsmod`, and `logging.slabinfo`.

## Endpoint

```text
GET https://<host>:<port>/access/logging.meminfo
```

## HTTP Method

`GET` — read/query operation.

## Parameters

None — this is a read-only query.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/logging.meminfo"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- logging.meminfo fields -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"logging.meminfo"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/logging.top` — performs a top command
- `access/stats` — returns current appliance traffic and usage statistics
- `access/logging.resetstats` — resets statistics
