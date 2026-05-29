# access/geogenerateksk

**Category**: GEO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `New-GeoDNSSECKeySigningKey`

## Description

Creates GEO dnsseckey signing key.

## Endpoint

```text
POST https://<host>:<port>/access/geogenerateksk?algorithm=<algorithm>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `algorithm` | string | Yes | Algorithm value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/geogenerateksk?algorithm=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- geogenerateksk operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/geoacl` — handles geoacl
- `access/geostats` — retrieves GEO statistics
- `access/geoimportksk` — handles geoimportksk
