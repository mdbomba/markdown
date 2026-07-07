# access/modparams

**Category**: GEO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-GeoMiscParameter`

## Description

Updates GEO misc parameter.

## Endpoint

```text
POST https://<host>:<port>/access/modparams?sourceofauthority=<sourceofauthority>&namesrv=<namesrv>&soaemail=<soaemail>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `sourceofauthority` | string | No | Sourceofauthority value for this command. |
| `namesrv` | string | No | Namesrv value for this command. |
| `soaemail` | string | No | Soaemail value for this command. |
| `perzonesoa` | boolean | No | Perzonesoa value for this command. |
| `dclustunavail` | boolean | No | Dclustunavail value for this command. |
| `ednsecs` | boolean | No | Ednsecs value for this command. |
| `glueip` | string | No | Glueip IP address. |
| `txt` | string | No | Txt value for this command. |
| `ttl` | integer | No | Ttl value for this command. |
| `persist` | integer | No | Persist value for this command. |
| `checkinterval` | integer | No | Checkinterval value for this command. |
| `conntimeout` | integer | No | Conntimeout value for this command. |
| `retryattempts` | integer | No | Retryattempts value for this command. |
| `zone` | string | No | Zone value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/modparams?sourceofauthority=example&namesrv=example&soaemail=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- modparams operation completed -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"modparams","sourceofauthority":"example","namesrv":"example","soaemail":"example","perzonesoa":"1","dclustunavail":"1","ednsecs":"1","glueip":"example","txt":"example","ttl":"1","persist":"1","checkinterval":"1","conntimeout":"1","retryattempts":"1","zone":"example"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/clustchangeloc` — updates GEO cluster coordinates
- `access/listparams` — retrieves GEO misc parameter
- `access/locdataupdate` — updates GEO database
