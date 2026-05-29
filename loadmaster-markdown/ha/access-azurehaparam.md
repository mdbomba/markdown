# access/azurehaparam

**Category**: HA  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-LmAzureHAConfiguration`

## Description

Updates lm azure haconfiguration.

## Endpoint

```text
POST https://<host>:<port>/access/azurehaparam?partner=<partner>&hcai=<hcai>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `partner` | string | No | Peer partner identifier or address. |
| `hcai` | string | No | Required literal value `1`. Hcai value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/azurehaparam?partner=198.51.100.60&hcai=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- azurehaparam operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/awshaparam` — updates lm AWS haconfiguration
- `access/azurehamode` — updates lm azure hamode
- `access/getCloudHaParams` — retrieves cloud HA params
