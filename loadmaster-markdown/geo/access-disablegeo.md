# access/disablegeo

**Category**: GEO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Disable-LmGeoPack`

## Description

Disables lm GEO pack.

## Endpoint

```text
POST https://<host>:<port>/access/disablegeo
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

None — this endpoint does not take query parameters in the documented form.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.14:443/access/disablegeo"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
<Success>Command completed ok</Success>
</Response>
```

## Live Validation (2026-06-16)

- Successfully disabled GEO on firmware 7.2.63.x (Free LoadMaster license)
- HTTP method is GET (not POST) — legacy API pattern
- No parameters required
- Disabling GEO stops the DNS listener on port 53 (STIG recommendation: disable unused services)
- The STIG script checks `licenseinfo.Option` for "GEO" before attempting to disable
- Counterpart: `access/enablegeo` re-enables the GEO service


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"disablegeo"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/enablegeo` — enables lm GEO pack
