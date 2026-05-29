# access/factoryreset

**Category**: system  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Resets the appliance back to factory defaults.

## Endpoint

```text
POST https://<host>:<port>/access/factoryreset
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

None — this endpoint does not take query parameters in the documented form.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/factoryreset"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- factoryreset operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/setmotd` — sets the message-of-the-day banner shown by the appliance
- `access/notice` — retrieves or acknowledges appliance notices exposed through the REST API
- `access/installpatch` — uploads and installs a software patch package on the appliance
