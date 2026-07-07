# access/listtemplates

**Category**: templates  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Get-Template`

## Description

Retrieves template.

## Endpoint

```text
GET https://<host>:<port>/access/listtemplates
```

## HTTP Method

`GET` — read/query operation.

## Parameters

None — this is a read-only query.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/listtemplates"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- listtemplates fields -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"listtemplates"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## Live Validation (2026-06-16)

- Returns empty `<Data></Data>` when no templates are installed
- After uploading Exchange 2019 bundle, returns 5 `<template>` elements with `<name>`, `<comment>`, and `<certified>` fields
- Template names from Exchange 2019 bundle: "Exchange 2019 Office Online Server", "Exchange 2019 HTTPS Offload", "Exchange 2019 HTTPS pass-through", "Exchange 2019 HTTPS re-encrypted", "Exchange 2019 SMTP"
- Template names are used as-is (with spaces) in the `addvs?template=` parameter (URL-encode the spaces)

## See Also

- `access/uploadtemplate` — installs template
- `access/deltemplate` — removes template
- `access/uploadvserrfile` — installs vserror file
