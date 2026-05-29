# access/restorepatch

**Category**: system  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Uninstall-LmPatch`

## Description

Reverts the appliance to the previously installed patch level when available.

## Endpoint

```text
POST https://<host>:<port>/access/restorepatch
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

None — this endpoint does not take query parameters in the documented form.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/restorepatch"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- restorepatch operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/factoryreset` — resets the appliance back to factory defaults
- `access/installpatch` — uploads and installs a software patch package on the appliance
- `access/getpreviousversion` — returns information about the previously installed software version
