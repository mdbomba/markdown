# access/addroute

**Category**: network  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `New-NetworkRoute`

## Description

Adds a static route to the appliance routing table.

## Endpoint

```text
POST https://<host>:<port>/access/addroute?destination=<destination>&cidr=<cidr>&gateway=<gateway>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `destination` | string | Yes | Destination value for this command. |
| `cidr` | integer | Yes | Cidr value for this command. |
| `gateway` | string | Yes | Gateway value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/addroute?destination=example&cidr=example&gateway=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- addroute operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/delroute` — deletes a static route from the appliance routing table
- `access/showroute` — retrieves the configured static routes
