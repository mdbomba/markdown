# access/geoacl.installnow

**Category**: GEO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Installs any downloaded IP access list updates now.

## Endpoint

```text
POST https://<host>:<port>/access/geoacl.installnow
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

None — this command takes no parameters.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/geoacl.installnow"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- geoacl.installnow operation completed -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"geoacl.installnow"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/geoacl.getsettings` — retrieves the IP access list settings
- `access/geoacl.updatenow` — downloads the updates now
- `access/geoacl.setautoinstall` — enables or disables automatic installation of IP access list updates
