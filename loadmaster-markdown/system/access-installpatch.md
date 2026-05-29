# access/installpatch

**Category**: system  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Install-LmPatch`

## Description

Uploads and installs a software patch package on the appliance.

## Endpoint

```text
POST https://<host>:<port>/access/installpatch?path=<path>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `path` | string | Yes | Local file path supplied to the PowerShell cmdlet; represented as uploaded or downloaded content in REST usage. |
| `confirm` | string | No | Required literal value `1`. Confirm value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST --data-binary "@patch.upd" "https://10.0.0.69:443/access/installpatch?path=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- installpatch operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/notice` — retrieves or acknowledges appliance notices exposed through the REST API
- `access/factoryreset` — resets the appliance back to factory defaults
- `access/restorepatch` — reverts the appliance to the previously installed patch level when available
