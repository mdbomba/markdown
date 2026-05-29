# access/moddomain

**Category**: GEO  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-SAMLSPEntity`

## Description

Updates samlspentity.

## Endpoint

```text
POST https://<host>:<port>/access/moddomain?domain=<domain>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `domain` | string | Yes | Domain name targeted by the command. |
| `idpentityid` | string | No | Idpentityid identifier. |
| `idpssourl` | string | No | Idpssourl value for this command. |
| `idplogoffurl` | string | No | Idplogoffurl value for this command. |
| `idpcert` | string | No | Idpcert value for this command. |
| `spentityid` | string | No | Spentityid identifier. |
| `spcert` | string | No | Spcert value for this command. |
| `idp_match_cert` | integer | No | Idp Match Cert value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/moddomain?domain=example.com"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- moddomain operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/showdomain` — retrieves samldomain
- `access/adddomain` — creates ssodomain
- `access/deldomain` — removes ssodomain
