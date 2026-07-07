# access/delvs

**Category**: virtual services  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Remove-AdcVirtualService`

## Description

Deletes an existing virtual service.

## Endpoint

```text
POST https://<host>:<port>/access/delvs?vs=<vs>&port=<port>&prot=<prot>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `vs` | string | No | Virtual service IP address or internal virtual service identifier, depending on the command form. |
| `port` | integer | No | Virtual service port number. |
| `prot` | string | No | Virtual service protocol, typically `tcp` or `udp`. |
| `force` | boolean | No | Force value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/delvs?vs=192.0.2.10&port=443&prot=tcp"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- delvs operation completed -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"delvs","vs":"10.0.0.50","port":"443","prot":"tcp","force":"1"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- The reference guide shows multiple endpoint forms for this command, including alternate addressing by ID or name where applicable.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## Live Validation (2026-06-16)

- Successfully deleted VS using `vs=<IP>&port=<port>&prot=tcp` on firmware 7.2.63.x
- Deleting a Master VS also removes all associated sub-VS
- When deleting template-created VS to rebuild with a different template, delete all related VS (Master + HTTP Redirect + SMTP + OOS) individually
- Response: `Command completed ok`
- The RS associated with the VS are also removed

## See Also

- `access/addvs` — creates a new virtual service and applies any supplied settings during creation
- `access/showvs` — retrieves detailed configuration and runtime status for one virtual service
- `access/listvs` — lists all virtual services configured on the LoadMaster
