# access/awshamode

**Category**: HA  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-LmAwsHAMode`

## Description

Updates lm AWS hamode.

## Endpoint

```text
POST https://<host>:<port>/access/awshamode?hamode=<hamode>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `hamode` | string | Yes | High-availability mode selection. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/awshamode?hamode=1"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- awshamode operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/cluster` — handles cluster
- `access/setlmcommsecret` — updates lmcomm secret
- `access/awshaparam` — updates lm AWS haconfiguration
