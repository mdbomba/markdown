# access/geodeleteksk

**Category**: GEO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Remove-GeoDNSSECKeySigningKey`

## Description

Removes GEO dnsseckey signing key.

## Endpoint

```text
POST https://<host>:<port>/access/geodeleteksk
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

None — this endpoint does not take query parameters in the documented form.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/geodeleteksk"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- geodeleteksk operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/geogenerateksk` — creates GEO dnsseckey signing key
- `access/geoimportksk` — handles geoimportksk
- `access/geosetdnssec` — updates GEO dnssecstatus
