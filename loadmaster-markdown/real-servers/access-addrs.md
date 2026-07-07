# access/addrs

**Category**: real servers  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `New-AdcRealServer`

## Description

Adds a real server to a virtual service.

## Endpoint

```text
POST https://<host>:<port>/access/addrs?rs=<rs>&rsport=<rsport>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `vs` | string | No | Virtual service IP address or internal virtual service identifier, depending on the command form. |
| `port` | integer | No | Virtual service port number. |
| `prot` | string | No | Virtual service protocol, typically `tcp` or `udp`. |
| `rs` | string | Yes | Real server IP address or internal real server identifier. |
| `rsport` | integer | Yes | Real server listening port. |
| `weight` | integer | No | Weight value for this command. |
| `forward` | string | No | Forward value for this command. |
| `enable` | boolean | No | Boolean-style enable flag used by the endpoint. |
| `non_local` | boolean | No | Non Local value for this command. |
| `limit` | integer | No | Limit value for this command. |
| `ratelimit` | integer | No | Ratelimit value for this command. |
| `critical` | boolean | No | Critical value for this command. |
| `addtoallsubvs` | boolean | No | Addtoallsubvs value for this command. |
| `follow` | integer | No | Follow value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/addrs?rs=192.0.2.21&rsport=443"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- addrs operation completed -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"addrs","vs":"10.0.0.50","port":"443","prot":"tcp","rs":"10.0.0.50","rsport":"443","weight":"1","forward":"example","enable":"1","non_local":"1","limit":"1","ratelimit":"1","critical":"1","addtoallsubvs":"1","follow":"1"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## Adding RS to Sub-VS (Content Switching)

When a virtual service uses content switching (Master VS with sub-VS), real servers must be
added to each **sub-VS individually** — not to the Master VS.

### Sub-VS Addressing (Live Validated 2026-06-16)

For sub-VS, the `vs` parameter takes the **numeric VSIndex** (not an IP address):

```bash
# CORRECT: Add RS to sub-VS using its numeric Index
curl -sk -u "bal:PASS" "https://$LM_IP/access/addrs?vs=2&rs=10.0.0.4&rsport=443"

# WRONG: Adding RS to a Master VS directly fails
curl -sk -u "bal:PASS" "https://$LM_IP/access/addrs?vs=10.0.0.100&port=443&prot=tcp&rs=10.0.0.4&rsport=443"
# Returns: "Couldn't create RS"

# WRONG: Using vs_index parameter does not work for sub-VS
curl -sk -u "bal:PASS" "https://$LM_IP/access/addrs?vs_index=2&rs=10.0.0.4&rsport=443"
# Returns: "vs: Address Value missing"
```

### Identifying Sub-VS Indexes

Use `showvs` on the Master VS to list sub-VS indexes:
```bash
curl -sk -u "bal:PASS" "https://$LM_IP/access/showvs?vs=10.0.0.100&port=443&prot=tcp"
# Look for <SubVS><VSIndex>2</VSIndex></SubVS> entries
```

### Adding RS to Standalone VS (non-Master)

For standalone virtual services (SMTP, OOS, HTTP Redirect), use the standard IP+port addressing:
```bash
curl -sk -u "bal:PASS" "https://$LM_IP/access/addrs?vs=10.0.0.100&port=25&prot=tcp&rs=10.0.0.4&rsport=25"
```

### Key Behavior Rules
| VS Type | `vs` parameter | Works? |
|---------|---------------|--------|
| Standalone VS | IP address (e.g., `10.0.0.100`) | Yes (also requires `port` + `prot`) |
| Master VS (has sub-VS) | IP address | No — "Couldn't create RS" |
| Sub-VS | Numeric VSIndex (e.g., `2`) | Yes (no `port`/`prot` needed) |

### APIv2 Confirmation (2026-06-16)

The sub-VS addressing pattern works identically on APIv2. All 10 sub-VS and 3 standalone VS
were successfully configured in a single run using APIv2 exclusively:

```bash
# Sub-VS via APIv2 (numeric index as "vs")
curl -sk -X POST "https://$LM_IP/accessv2" \
  -d '{"apiuser":"bal","apipass":"PASS","cmd":"addrs","vs":"2","rs":"10.0.0.4","rsport":"443"}'
# Response: {"code": 200, "message": "ok", "status": "ok"}

# Standalone VS via APIv2 (IP address as "vs", with port/prot)
curl -sk -X POST "https://$LM_IP/accessv2" \
  -d '{"apiuser":"bal","apipass":"PASS","cmd":"addrs","vs":"10.0.0.100","port":"25","prot":"tcp","rs":"10.0.0.4","rsport":"25"}'
```

## See Also

- `access/modrs` — modifies the settings of a real server
- `access/delrs` — deletes a real server from a virtual service
- `access/showrs` — retrieves details for one real server attached to a virtual service
