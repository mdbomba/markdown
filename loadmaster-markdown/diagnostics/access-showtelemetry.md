# access/showtelemetry

**Category**: diagnostics  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Get-Telemetry`

## Description

Retrieves telemetry.

## Endpoint

```text
GET https://<host>:<port>/access/showtelemetry?iface=<iface>
```

## HTTP Method

`GET` — read/query operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `iface` | integer | No | Network interface identifier. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/showtelemetry?iface=1"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- showtelemetry fields -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- The reference guide shows multiple endpoint forms for this command, including alternate addressing by ID or name where applicable.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/getraiddisksinfo` — retrieves lm RAID controller disk
- `access/getraidinfo` — retrieves lm RAID controller
- `access/enabletelemetry` — enables telemetry
