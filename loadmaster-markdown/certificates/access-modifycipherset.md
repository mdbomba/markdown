# access/modifycipherset

**Category**: certificates  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-TlsCipherSet`

## Description

Updates TLS cipher set.

## Endpoint

```text
POST https://<host>:<port>/access/modifycipherset?name=<name>&value=<value>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Object name used by the command. |
| `value` | string | Yes | New value to apply to the selected parameter. |

## Example Request

```bash
# Create a custom FIPS2 cipher set (STIG hardening)
curl -sk -u "bal:PASSWORD" "https://10.0.0.14:443/access/modifycipherset?name=FIPS2&value=ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:AES256-GCM-SHA384:AES256-SHA256:ECDHE-RSA-AES128-GCM-SHA256:AES128-GCM-SHA256:AES128-SHA256"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
<Success>Cipher set updated</Success>
</Response>
```

## Live Validation (2026-06-16)

- Successfully created custom `FIPS2` cipher set on firmware 7.2.63.x
- The `name` parameter is the cipher set name (creates if it doesn't exist, updates if it does)
- The `value` parameter is a colon-separated list of OpenSSL cipher names
- If the cipher set already exists, it is overwritten
- After creating a custom cipher set, assign it via:
  - `access/set?param=WUICipherset&value=FIPS2` (inbound WUI)
  - `access/set?param=OutboundCipherset&value=FIPS2` (outbound connections)
- HTTP method is actually GET (not POST) despite documentation — legacy API pattern
- The FIPS2 set for STIG removes 3DES, SHA1, and DH<2048 from the standard FIPS set


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"modifycipherset","name":"example-name","value":"example-value"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Certificate and licensing workflows can take noticeably longer than simple queries. A client timeout of `max_time=60` is recommended.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/leaccountinfo` — retrieves leaccount info
- `access/getcipherset` — retrieves TLS cipher set
- `access/delcipherset` — can be used to delete an existing custom cipher set
