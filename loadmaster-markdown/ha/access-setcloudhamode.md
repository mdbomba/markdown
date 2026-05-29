# access/setcloudhamode

**Category**: HA  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-LmCloudHAMode`

## Description

Updates lm cloud hamode.

## Endpoint

```text
POST https://<host>:<port>/access/setcloudhamode?hamode=<hamode>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `hamode` | string | Yes | High-availability mode selection. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/setcloudhamode?hamode=1"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- setcloudhamode operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/getcloudhaparameters` — retrieves cloudhaparameters
- `access/getcloudhaparams` — retrieves lm cloud HA configuration
- `access/setcloudhaparam` — updates lm cloud HA configuration
