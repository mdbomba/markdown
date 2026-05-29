# access/exportvstmplt

**Category**: virtual services  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Export-VSTemplate`

## Description

Exports a virtual service definition as a reusable template file.

## Endpoint

```text
POST https://<host>:<port>/access/exportvstmplt?path=<path>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `vs` | string | No | Virtual service IP address or internal virtual service identifier, depending on the command form. |
| `port` | integer | No | Virtual service port number. |
| `prot` | string | No | Virtual service protocol, typically `tcp` or `udp`. |
| `path` | string | Yes | Local file path supplied to the PowerShell cmdlet; represented as uploaded or downloaded content in REST usage. |
| `force` | boolean | No | Force value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/exportvstmplt?path=example" -o exportvstmplt.out
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- exportvstmplt operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/delvs` — deletes an existing virtual service
- `access/modvs` — modifies the settings of an existing virtual service
