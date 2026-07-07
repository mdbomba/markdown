# access/listvs

**Category**: virtual services  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Get-AdcVirtualService`

## Description

Lists all virtual services configured on the LoadMaster.

## Endpoint

```text
GET https://<host>:<port>/access/listvs?vs=<vs>&port=<port>&prot=<prot>
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
curl -sk -u "bal:PASSWORD" "https://10.0.0.69:443/access/listvs?vs=192.0.2.10&port=443&prot=tcp"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- listvs fields -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"listvs","vs":"10.0.0.50","port":"443","prot":"tcp"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- This is a safe read/query operation and does not modify appliance state.

## Live Validation (2026-06-16)

- Returns all VS including Master VS, sub-VS (content switching children), and standalone VS
- Sub-VS appear with `<VSPort>0</VSPort>` and `<MasterVSID>N</MasterVSID>` where N = parent VS Index
- Key fields per VS: `Index`, `VSAddress`, `VSPort`, `NickName`, `Status`, `Protocol`, `Enable`, `MasterVS`, `MasterVSID`, `NumberOfRSs`
- Status values observed: `Down` (no healthy RS), `Redirect` (301/302 redirect VS), `Up`
- No parameters required — returns all VS in one response

- `access/showvs` — retrieves detailed configuration and runtime status for one virtual service
- `access/addvs` — creates a new virtual service and applies any supplied settings during creation
