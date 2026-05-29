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
