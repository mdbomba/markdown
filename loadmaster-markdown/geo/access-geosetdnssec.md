# access/geosetdnssec

**Category**: GEO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-GeoDNSSECStatus`

## Description

Updates GEO dnssecstatus.

## Endpoint

```text
POST https://<host>:<port>/access/geosetdnssec?status=<status>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `status` | string | Yes | Status value for this command. |
| `Enable` | string | No | Required literal value `1`. Boolean-style enable flag used by the endpoint. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/geosetdnssec?status=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- geosetdnssec operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/geoimportksk` — handles geoimportksk
- `access/geodeleteksk` — removes GEO dnsseckey signing key
- `access/geoshowdnssec` — retrieves GEO dnssecconfiguration
