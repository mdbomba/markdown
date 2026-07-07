# LoadMaster API Error Code Reference

## HTTP Status Codes

The LoadMaster API returns standard HTTP status codes. The response body contains additional detail in either XML (APIv1) or JSON (APIv2) format.

### Success

| Code | Status | Meaning |
|------|--------|---------|
| `200` | OK | Command completed successfully |

**APIv1 success response:**
```xml
<Response stat="200" code="ok">
  <Success><Data><!-- result --></Data></Success>
</Response>
```

**APIv2 success response:**
```json
{"code": 200, "message": "Command completed ok", "status": "ok"}
```

### Client Errors

| Code | Status | Common Causes |
|------|--------|---------------|
| `401` | Unauthorized | Wrong credentials, API key expired, API disabled after licensing |
| `404` | Not Found | Invalid endpoint URL, command does not exist |
| `405` | Method Not Allowed | Using GET on an APIv2 endpoint (requires POST) |
| `422` | Unprocessable Entity | Invalid parameter, missing required parameter, resource already exists, resource not found |

### Server / Connection Errors

| Code | Status | Common Causes |
|------|--------|---------------|
| `000` / connection reset | N/A | **APIv1 URL length exceeded** (~2000-4000 chars). Switch to APIv2. |
| `500` | Internal Server Error | Appliance error, firmware bug |
| `503` | Service Unavailable | Appliance is booting, not yet licensed, or overloaded |

---

## API Error Messages

### APIv2 Error Response Format

```json
{"code": 422, "message": "Error description here", "status": "fail"}
```

### APIv1 Error Response Format

```xml
<Response stat="422" code="fail">
  <Error>Error description here</Error>
</Response>
```

---

## Common Error Messages and Solutions

### Authentication & Access

| Error Message | Cause | Solution |
|---------------|-------|----------|
| `401 Unauthorized` | Wrong username/password or API key | Verify credentials; check if API key was revoked |
| `401` after licensing | API is disabled after `alsilicense` | Run `set?param=enableapi&value=yes` |
| `401` after password change | Cached credentials are stale | Use the new password; re-enable API if needed |

### Parameter Errors

| Error Message | Cause | Solution |
|---------------|-------|----------|
| `Unknown parameter value` | Parameter name does not exist | Check `getall` for valid parameter names |
| `Invalid value` | Value is outside acceptable range | Check parameter docs for valid values |
| `Value cannot be empty` | Required parameter missing | Provide the required parameter |
| `Parameter is read-only` | Trying to set a read-only value (e.g., `version`, `serialnumber`) | These values cannot be modified |

### Virtual Service Errors

| Error Message | Cause | Solution |
|---------------|-------|----------|
| `Virtual Service already exists` | VS with same IP/port/protocol exists | Use `modvs` to modify or `delvs` first |
| `Virtual Service not found` | Wrong IP, port, or protocol | Use `listvs` to find the correct VS |
| `Port out of range` | Port number < 1 or > 65535 | Use a valid port number |

### Real Server Errors

| Error Message | Cause | Solution |
|---------------|-------|----------|
| `Couldn't create RS` | Adding RS directly to a Master VS (SubVS-enabled) | Add the RS to a SubVS by its numeric index instead |
| `Real Server already exists` | RS with same IP:port already in the VS | Use `modrs` to modify the existing RS |
| `Real Server not found` | Wrong RS IP or port | Use `showvs` to list current real servers |

### Certificate Errors

| Error Message | Cause | Solution |
|---------------|-------|----------|
| `Certificate not found` | Certificate name doesn't exist | Use `listcert` to see installed certificates |
| `Invalid certificate data` | Malformed PEM/PKCS12 data | Verify the certificate format and base64 encoding |
| `Certificate in use` | Trying to delete a cert assigned to a VS | Remove the cert from all VS first, then delete |

### HA Errors

| Error Message | Cause | Solution |
|---------------|-------|----------|
| `Partner not available` | HA partner is unreachable | Check network connectivity and partner status |
| `HA mode change requires reboot` | Setting hamode without rebooting | Reboot the appliance after changing hamode |

### Licensing Errors

| Error Message | Cause | Solution |
|---------------|-------|----------|
| `Magic token invalid` | Using an expired or wrong magic token | Re-run `readeula` to get a fresh token |
| `License activation failed` | Wrong credentials or no available licenses | Verify KEMP account credentials and license pool |
| `Out of sequence` | Skipping a licensing step | Follow the exact sequence: readeula -> accepteula -> accepteula2 -> alsilicense |

---

## APIv1 vs APIv2 Error Behavior Differences

| Scenario | APIv1 Behavior | APIv2 Behavior |
|----------|---------------|----------------|
| Long parameter value | **Silent failure** — HTTP 000, connection reset | Works correctly — no size limit |
| Invalid command | Returns 422 XML error | Returns 422 JSON error |
| Missing auth | Returns 401 with HTML login page | Returns 401 JSON error |
| Boolean parameter | Expects `yes`/`no` strings | Accepts `true`/`false`, `yes`/`no`, `0`/`1` |

---

## Debugging Tips

### Get the raw response for inspection

```bash
# APIv1 — full XML response
curl -sk -u "bal:PASSWORD" "https://$LM_IP/access/listvs" | xmllint --format -

# APIv2 — full JSON response
curl -sk -X POST "https://$LM_IP/accessv2" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"listvs"}' | jq .
```

### Check if the API is enabled

```bash
# This works even if API is disabled (it's a WUI endpoint)
curl -sk "https://$LM_IP/access/get?param=enableapi" -u "bal:PASSWORD"
```

### List all available commands

```json
{"apiuser":"bal","apipass":"PASSWORD","cmd":"listapi"}
```

### Dump all parameters to find the right name

```json
{"apiuser":"bal","apipass":"PASSWORD","cmd":"getall"}
```
