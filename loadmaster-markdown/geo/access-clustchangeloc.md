# access/clustchangeloc

**Category**: GEO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-GeoClusterCoordinates`

## Description

Updates GEO cluster coordinates.

## Endpoint

```text
POST https://<host>:<port>/access/clustchangeloc?IP=<IP>&latsecs=<latsecs>&longsecs=<longsecs>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `IP` | string | Yes | IPv4 or IPv6 address value used by the command. |
| `latsecs` | integer | Yes | Latsecs value for this command. |
| `longsecs` | integer | Yes | Longsecs value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/clustchangeloc?IP=198.51.100.20&latsecs=example&longsecs=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- clustchangeloc operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/delcluster` — removes GEO cluster
- `access/modcluster` — updates GEO cluster
- `access/listparams` — retrieves GEO misc parameter
