# access/getpreviousversion

**Category**: system  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Get-LmPreviousFirmwareVersion`

## Description

Returns information about the previously installed software version.

## Endpoint

```text
GET https://<host>:<port>/access/getpreviousversion
```

## HTTP Method

`GET` — read/query operation.

## Parameters

None — this is a read-only query.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/getpreviousversion"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- getpreviousversion fields -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/installpatch` — uploads and installs a software patch package on the appliance
- `access/restorepatch` — reverts the appliance to the previously installed patch level when available
- `access/enablexroot` — enables shell-level xroot access for support or recovery workflows
