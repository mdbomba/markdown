# access/aclcontrol.isifblock

**Category**: LDAP  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `—`

## Description

Checks if the restrict traffic to interfaces option is enabled. When enabled, restrictions are enforced upon routing between attached subnets. Returns `block` if enabled or `free` if disabled.

## Endpoint

```text
GET https://<host>:<port>/access/aclcontrol.isifblock
```

## HTTP Method

`GET` — read/query operation.

## Parameters

None — this is a read-only query.

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/aclcontrol.isifblock"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- aclcontrol.isifblock fields -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"aclcontrol.isifblock"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## See Also

- `access/aclcontrol` — removes global packet filter ACL
- `access/aclcontrol.isenabled` — checks if the packet routing filter is enabled
- `access/aclcontrol.isdrop` — checks if connections are dropped or rejected when on the blocked list
