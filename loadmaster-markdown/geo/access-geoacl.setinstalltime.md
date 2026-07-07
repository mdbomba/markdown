# access/geoacl.setinstalltime

**Category**: GEO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Sets the time of the automatic installation. The hour value is from the 24-hour clock (0-23). Minutes cannot be specified. It is not possible to set the install time if automatic installation is disabled.

## Endpoint

```text
POST https://<host>:<port>/access/geoacl.setinstalltime?hour=<hour>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `hour` | integer | Yes | Hour value from the 24-hour clock (0-23). For example, 13 is 1pm. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/geoacl.setinstalltime?hour=13"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- geoacl.setinstalltime operation completed -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"geoacl.setinstalltime","hour":"4"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/geoacl.getsettings` — retrieves the IP access list settings
- `access/geoacl.setautoinstall` — enables or disables automatic installation of IP access list updates
- `access/geoacl.installnow` — installs downloaded updates now
