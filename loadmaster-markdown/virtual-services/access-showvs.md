# access/showvs

**Category**: virtual services  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Get-AdcVirtualService`

## Description

Retrieves detailed configuration and runtime status for one virtual service.

## Endpoint

```text
GET https://<host>:<port>/access/showvs?vs=<vs>&port=<port>&prot=<prot>
```

## HTTP Method

`GET` — read/query operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `vs` | string | No | Virtual service IP address or internal virtual service identifier, depending on the command form. |
| `port` | integer | No | Virtual service port number. |
| `prot` | string | No | Virtual service protocol, typically `tcp` or `udp`. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/showvs?vs=192.0.2.10&port=443&prot=tcp"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- showvs fields -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"showvs","vs":"10.0.0.50","port":"443","prot":"tcp"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## Live Validation (2026-06-16)

- For Master VS (content switching), response includes `<SubVS>` elements listing child sub-VS:
  ```xml
  <SubVS><VSIndex>2</VSIndex><RsIndex>1</RsIndex></SubVS>
  ```
- `<MasterVS>10</MasterVS>` indicates the VS has 10 sub-VS (not a parent reference)
- Sub-VS cannot be queried individually via `showvs` — they return "vs: Address Value missing"
- Use `vs=<IP>&port=<port>&prot=tcp` to address standalone or Master VS
- Key fields: `SSLReencrypt`, `CheckType`, `CheckUrl`, `Persist`, `Schedule`, `NickName`, `SubVS` list

- `access/listvs` — lists all virtual services configured on the LoadMaster
- `access/modvs` — modifies the settings of an existing virtual service
