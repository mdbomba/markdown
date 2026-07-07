# access/set_initial_passwd

## `passwd`

**Type:** `string`  
**Required:** Yes  
**Default:** `<none>`  

### Description
Sets the initial password for the API account (`bal`) during post-license hardening.

---

### Allowed Values / Options

| Value | Description |
|-------|-------------|
| `<new-password>` | New password to be set on the appliance. |

> **Note:** Avoid shell-unescaped special characters when calling directly through query strings.

---

### Constraints
- Must comply with appliance password policy.
- Should be URL-encoded if it contains reserved query characters.

---

### Behavior Rules
- If omitted: password reset step does not occur.
- What overrides this field: local account policy and validation checks.
- Interactions with other parameters: none in observed call form.

---

### Examples

#### Example 1 - Basic Usage
```json
{
  "primitiveName": "MyS3curePassword"
}
```

#### Example 2 - Request Form
```http
GET /access/set_initial_passwd?passwd=<new-password>
Authorization: Basic <api_user:api_pass>
```

### Timing Note
After `alsilicense` completes, the appliance undergoes a post-licensing restart of internal
services. There is a **significant and variable delay** (observed up to ~25 seconds) before
`set_initial_passwd` becomes available. Callers should implement a retry loop (recommended:
5 attempts with 5-second gaps) rather than a fixed sleep. Calling too early returns a
connection error or non-`ok` response code.

### Live Validation (2026-06-16)
- On firmware 7.2.54.x (KVM), `set_initial_passwd` was available **within 5 seconds** after
  `alsilicense` completed for a Free LoadMaster license activation.
- No authentication (`-u bal:pass`) was required for this call — it uses no credentials on
  a freshly licensed appliance.
- After this command succeeds, the API interface is disabled by default. You **must** call
  `access/set?param=enableapi&value=1` (with the new credentials) before further API usage.

### Complete Post-Licensing Sequence
```bash
# 1. Set initial password (retry loop recommended)
curl -sk "https://$LM_IP/access/set_initial_passwd?passwd=MyNewPassword"

# 2. Re-enable API interface (REQUIRED)
curl -sk -u "bal:MyNewPassword" "https://$LM_IP/access/set?param=enableapi&value=1"

# 3. Now the API is available for configuration commands
curl -sk -u "bal:MyNewPassword" "https://$LM_IP/access/showiface?iface=0"
```

## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"set_initial_passwd"}'
```
