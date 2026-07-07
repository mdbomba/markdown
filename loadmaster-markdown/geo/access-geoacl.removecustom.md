# access/geoacl.removecustom

**Category**: GEO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Removes an IP address or network from the allow list.

## Endpoint

```text
POST https://<host>:<port>/access/geoacl.removecustom?addr=<addr>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `addr` | string | Yes | IP address or network to remove from the allow list. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/geoacl.removecustom?addr=198.51.100.10"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- geoacl.removecustom operation completed -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"geoacl.removecustom","addr":"10.0.0.50"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/geoacl.addcustom` — adds an IP address or network to the allow list
- `access/geoacl.listcustom` — retrieves the user-defined allow list
- `access/geoacl.getsettings` — retrieves the IP access list settings
