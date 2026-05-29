# access/awshaparam

**Category**: HA  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-LmAwsHAConfiguration`

## Description

Updates lm AWS haconfiguration.

## Endpoint

```text
POST https://<host>:<port>/access/awshaparam?partner=<partner>&haprefered=<haprefered>&hcai=<hcai>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `partner` | string | No | Peer partner identifier or address. |
| `haprefered` | integer | No | Haprefered value for this command. |
| `hcai` | string | No | Required literal value `1`. Hcai value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/awshaparam?partner=198.51.100.60&haprefered=example&hcai=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- awshaparam operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/setlmcommsecret` — updates lmcomm secret
- `access/awshamode` — updates lm AWS hamode
- `access/azurehamode` — updates lm azure hamode
