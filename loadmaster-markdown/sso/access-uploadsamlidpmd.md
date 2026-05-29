# access/uploadsamlidpmd

**Category**: SSO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Install-SAMLIdpMetafile`

## Description

Is used to upload an IdP metadata file.

## Endpoint

```text
POST https://<host>:<port>/access/uploadsamlidpmd?domain=<domain>&path=<path>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `domain` | string | Yes | Domain name targeted by the command. |
| `path` | string | Yes | Local file path supplied to the PowerShell cmdlet; represented as uploaded or downloaded content in REST usage. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST --data-binary "@idp-metadata.xml" "https://10.0.0.69:443/access/uploadsamlidpmd?domain=example.com&path=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- uploadsamlidpmd operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/setrsaconfig` — installs ssorsaconfiguration file
- `access/setrsanodesecret` — installs ssorsanode secret and password
- `access/downloadsamlspcert` — exports samlspcert
