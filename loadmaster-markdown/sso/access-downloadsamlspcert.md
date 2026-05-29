# access/downloadsamlspcert

**Category**: SSO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Export-SAMLSPCert`

## Description

Exports samlspcert.

## Endpoint

```text
GET https://<host>:<port>/access/downloadsamlspcert?domain=<domain>&certificatefilepath=<certificatefilepath>[&...]
```

## HTTP Method

`GET` — read/query operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `domain` | string | Yes | Domain name targeted by the command. |
| `certificatefilepath` | string | Yes | Certificatefilepath value for this command. |
| `force` | boolean | No | Force value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/downloadsamlspcert?domain=example.com&certificatefilepath=example" -o downloadsamlspcert.out
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- downloadsamlspcert fields -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/setrsanodesecret` — installs ssorsanode secret and password
- `access/uploadsamlidpmd` — is used to upload an IdP metadata file
- `access/ssoimages` — handles ssoimages
