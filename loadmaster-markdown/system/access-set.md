# access/set

**Category**: system  
**Firmware tested**: 7.2.63.2.RELEASE  
**PS Cmdlet**: `Set-LmParameter`

## Description

Updates a single LoadMaster runtime parameter to a supplied value.

## Recommended: Use APIv2 (JSON)

APIv2 is the recommended interface for all `set` operations. It has no character limit
and returns JSON responses that are easier to parse.

```bash
# APIv2 (recommended default)
curl -sk -X POST "https://<host>:<port>/accessv2" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"set","param":"<parameter>","value":"<value>"}'

# Response: {"code": 200, "message": "Command completed ok", "status": "ok"}
```

## APIv1 Endpoint (Fallback)

Use APIv1 only for quick debugging or when APIv2 is unavailable (pre-license phase).

```text
GET https://<host>:<port>/access/set?param=<parameter>&value=<value>
```

**WARNING:** APIv1 has a URL character limit (~2000-4000 chars). Values exceeding this
cause a silent connection reset (HTTP 000). Always use APIv2 for HTML banners or other
long values.

## HTTP Method

- **APIv2**: `POST` with JSON body
- **APIv1**: `GET` with query-string parameters (legacy pattern)

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `param` | string | Yes | The parameter name to set (e.g., `hostname`, `ntphost`, `enableapi`) |
| `value` | string | Yes | The value to assign to the parameter |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.14:443/access/set?param=hostname&value=vlm14"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
<Success>Command completed ok</Success>
</Response>
```

## Live Validation (2026-06-16)

All of the following parameters were successfully set on firmware 7.2.63.x:

### System / Identity
| Parameter | Example Value | Notes |
|-----------|---------------|-------|
| `hostname` | `vlm14` | Sets appliance hostname |
| `enableapi` | `1` | Re-enables API after licensing (**required**) |

### Network / DNS
| Parameter | Example Value | Notes |
|-----------|---------------|-------|
| `nameserver` | `8.8.8.8,8.8.4.4` | Comma-separated for multiple; no `namesecondary` param exists |
| `ntphost` | `pool.ntp.org` | Triggers immediate NTP sync; returns offset in response |
| `admingw` | `10.0.0.1` | Admin gateway (for management traffic) |
| `multigw` | `1` | Enable multi-gateway |
| `nonlocalrs` | `yes` | Allow RS on different subnets |
| `subnetorigin` | `yes` | Subnet originating requests |

### Session / Authentication
| Parameter | Example Value | Notes |
|-----------|---------------|-------|
| `sessioncontrol` | `yes` | Enable session management |
| `sessionbasicauth` | `0` | Disable basic auth (STIG) |
| `sessionidletime` | `600` | Idle timeout in seconds |
| `sessionmaxfailattempts` | `5` | Account lockout threshold |
| `sessionconcurrent` | `3` | Max concurrent admin sessions |
| `adminclientaccess` | `1` | 0=password, 1=password or cert, 2=cert required |

### TLS / Cipher
| Parameter | Example Value | Notes |
|-----------|---------------|-------|
| `WUICipherset` | `FIPS2` | Inbound WUI cipher set |
| `OutboundCipherset` | `FIPS2` | Outbound TLS cipher set |
| `WUITLSProtocols` | `7` | 7 = TLS 1.2 + 1.3 only |
| `WUITLS13Ciphersets` | `TLS_AES_256_GCM_SHA384 TLS_AES_128_GCM_SHA256` | Space-separated (URL-encode spaces) |
| `sslrenegotiate` | `0` | Disable SSL renegotiation |
| `KcdCipherSha1` | `yes` | Force Kerberos AES256 |

### Logging / Banners
| Parameter | Example Value | Notes |
|-----------|---------------|-------|
| `CEFMsgFormat` | `yes` | Enable CEF log format |
| `SSHPreAuth` | `<text>` | Console pre-auth banner (URL-encode) |
| `WUIPreauth` | `<html>` | WUI pre-auth banner (use accessv2 JSON for long HTML) |

### Tethering
| Parameter | Example Value | Notes |
|-----------|---------------|-------|
| `Tethering` | `0` | Disable call-home. **Fails on Free/MELA/SPLA licenses** with "Cannot change tethering in Online Only mode" |

### Error Responses
| Error | Cause |
|-------|-------|
| `Unknown parameter value <name>` | Parameter name doesn't exist (e.g., `namesecondary`) |
| `Cannot change tethering in Online Only mode` | Free license requires mandatory tethering |


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"set","param":"hostname","value":"example-value"}'
```

## Notes

- For long values (HTML banners), the APIv1 query-string has a **character limit** that causes
  connection resets (HTTP 000) when exceeded. Use the APIv2 JSON endpoint instead (see below).
- See `params-reference.md` for the complete list of parameter names and current values.

## APIv1 vs APIv2 Character Limit Issue (Live Validated 2026-06-16)

The LoadMaster exposes two API interfaces:

| Interface | Endpoint | Format | Character Limit |
|-----------|----------|--------|-----------------|
| **APIv1** | `https://<host>/access/<command>?<params>` | XML response | Limited by URL/query-string length (~2000-4000 chars) |
| **APIv2** | `https://<host>/accessv2` | JSON request & response | No practical limit (POST body) |

### The Problem

When setting parameters with long values (e.g., HTML warning banners), the APIv1 query-string
exceeds the maximum URL length. The connection is reset with HTTP status 000 (no response):

```bash
# FAILS — URL too long, connection reset (HTTP 000)
curl -sk -u "bal:PASS" "https://$LM_IP/access/set?param=WUIPreauth&value=<very-long-html-encoded-string>"
```

### The Solution: Use APIv2

The APIv2 endpoint accepts a JSON POST body with no practical size limit:

```bash
# WORKS — JSON body has no URL length constraint
curl -sk -X POST "https://$LM_IP/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASS","cmd":"set","param":"WUIPreauth","value":"<full-html-banner>"}'
```

### APIv2 Request Format

```json
{
  "apiuser": "bal",
  "apipass": "password",
  "cmd": "set",
  "param": "WUIPreauth",
  "value": "<html>...</html>"
}
```

Alternative authentication with API key:
```json
{
  "apikey": "<api-key>",
  "cmd": "set",
  "param": "WUIPreauth",
  "value": "<html>...</html>"
}
```

### APIv2 Response Format

```json
{
  "code": 200,
  "message": "Command completed ok",
  "status": "ok"
}
```

On failure:
```json
{
  "code": 422,
  "message": "Error description",
  "status": "fail"
}
```

### When to Use APIv2

| Scenario | Use APIv1 | Use APIv2 |
|----------|-----------|-----------|
| Short parameter values (hostname, ntphost) | Yes | Optional |
| Long HTML values (WUIPreauth, SSHPreAuth) | No (fails) | **Required** |
| Scripting with simple curl commands | Yes | Optional |
| Parameters with special characters | Requires URL-encoding | Easier (JSON escaping) |
| Retrieving values (get/getall) | Yes | Optional |

### Parameters Known to Require APIv2

| Parameter | Reason |
|-----------|--------|
| `WUIPreauth` | HTML warning banner (typically 1000+ characters) |
| `SSHPreAuth` | Console banner (may exceed limit if long) |

> **Note:** The `SSHPreAuth` console banner was set successfully via APIv1 in our testing
> (~500 chars), but the `WUIPreauth` HTML banner (~1800 chars) consistently failed via APIv1
> and required APIv2.

## See Also

- `access/get` — retrieves the current value of a single LoadMaster runtime parameter by name
- `access/getall` — returns the current values for LoadMaster runtime parameters in a single XML response
- `access/reboot` — handles reboot
