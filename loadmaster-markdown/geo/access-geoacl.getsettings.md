# access/geoacl.getsettings

**Category**: GEO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Retrieves the IP access list settings including auto-update status, last updated time, auto-install status, install time, and last installed time.

## Endpoint

```text
GET https://<host>:<port>/access/geoacl.getsettings
```

## HTTP Method

`GET` — read/query operation.

## Parameters

None — this is a read-only query.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/geoacl.getsettings"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- geoacl.getsettings fields -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"geoacl.getsettings"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/geoacl.setautoupdate` — enables or disables automatic IP access list updates
- `access/geoacl.setautoinstall` — enables or disables automatic installation of IP access list updates
- `access/geoacl.setinstalltime` — sets the time of the automatic installation
