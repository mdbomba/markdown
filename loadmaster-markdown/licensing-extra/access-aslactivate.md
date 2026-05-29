# access/aslactivate

**Category**: licensing extra  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Request-LicenseOnPremise`

## Description

Activates the appliance against an on-premise ASL licensing server.

## Endpoint

```text
POST https://<host>:<port>/access/aslactivate?aslhost=<aslhost>&aslport=<aslport>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `aslhost` | string | No | Hostname or IP address of the ASL licensing server. |
| `aslport` | integer | No | TCP port of the ASL licensing server. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/aslactivate?aslhost=192.0.2.50&aslport=443"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- aslactivate operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- The reference guide shows multiple endpoint forms for this command, including alternate addressing by ID or name where applicable.
- Certificate and licensing workflows can take noticeably longer than simple queries. A client timeout of `max_time=60` is recommended.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/killaslinstance` — stops the currently associated on-premise ASL licensing instance
- `access/getaslinfo` — retrieves on-premise ASL licensing server details
- `access/aslgetlicensetypes` — lists available license types from an on-premise ASL server
