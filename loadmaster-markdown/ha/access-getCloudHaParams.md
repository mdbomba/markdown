# access/getCloudHaParams

**Category**: HA  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Retrieves cloud HA parameters. This is the camelCase variant of the command used in both API v1 and v2 collections.

## Endpoint

```text
GET https://<host>:<port>/access/getCloudHaParams
```

## HTTP Method

`GET` — read/query operation.

## Parameters

None — this is a read-only query.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/getCloudHaParams"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- getCloudHaParams fields -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"getCloudHaParams"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.
- This command is case-sensitive in some deployments. See also `access/getcloudhaparams` (lowercase) and `access/getcloudhaparameters`.

## See Also

- `access/getcloudhaparams` — retrieves lm cloud HA configuration (lowercase variant)
- `access/getcloudhaparameters` — retrieves cloud HA parameters (alternate name)
- `access/setcloudhamode` — updates lm cloud hamode
- `access/setcloudhaparam` — updates lm cloud HA configuration
