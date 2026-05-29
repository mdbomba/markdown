# access/stats

**Category**: system  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Get-LogStatistics`

## Description

Returns current appliance traffic and usage statistics.

## Endpoint

```text
GET https://<host>:<port>/access/stats?vs=<vs>&rs=<rs>&totals=<totals>
```

## HTTP Method

`GET` — read/query operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `vs` | boolean | No | Virtual service IP address or internal virtual service identifier, depending on the command form. |
| `rs` | boolean | No | Real server IP address or internal real server identifier. |
| `totals` | boolean | No | Totals value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/stats?vs=192.0.2.10&rs=192.0.2.21&totals=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- stats fields -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/enablexroot` — enables shell-level xroot access for support or recovery workflows
- `access/logging` — retrieves logging statistics or downloads logging-related diagnostic artifacts, depending on the request parameters
- `access/vstotals` — returns aggregate totals across configured virtual services
