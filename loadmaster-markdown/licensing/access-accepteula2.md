# access/accepteula2

## `magic`

**Type:** `string`  
**Required:** Yes  
**Default:** `<none>`  

### Description
Second-stage EULA token returned by `access/accepteula`, used to finalize acceptance.

---

### Allowed Values / Options

| Value | Description |
|-------|-------------|
| `<magic2-token>` | Token returned from `access/accepteula` response. |

> **Note:** Token is short-lived and tied to EULA session state.

---

### Constraints
- Must be a non-empty token from immediate prior EULA step.
- Token must come from a successful `access/accepteula` call.

---

### Behavior Rules
- If omitted: EULA completion fails.
- What overrides this field: none.
- Interactions with other parameters: requires `accept=yes`.

---

### Examples

#### Example 1 - Basic Usage
```json
{
  "primitiveName": "magic2-token-from-accepteula"
}
```

## `accept`

**Type:** `string | enum | boolean`  
**Required:** Yes  
**Default:** `<none>`  

### Description
Indicates acceptance decision for the EULA finalization call.

---

### Allowed Values / Options

| Value | Description |
|-------|-------------|
| `yes` | Accept and finalize EULA. |
| `no` | Do not accept; licensing flow cannot continue. |

> **Note:** Script currently always sends `yes`.

---

### Constraints
- Expected to be `yes` for successful licensing workflow.

---

### Behavior Rules
- If omitted: request may fail validation.
- What overrides this field: none.
- Interactions with other parameters: used with `magic` token.

### Live Validation (2026-05-28)
- Both `accept=no` and `accept=yes` returned `code="fail"` when prior step did not produce `magic2`.
- Observed error message: `Accepteula2 called out of sequence`.
- Sequence integrity is strictly enforced by appliance state.
- PS module equivalent: `Confirm-LicenseEULA2 -Magic $magicString -Accept yes`
- Note: the PS module renews the magic string before this call:
  `$magicString = $lma1.Data.EULA2.MagicString  # renew the magic string !!`
  This is critical — the token from `accepteula` step 1 must be used here, not the original `readeula` token.

---

### Examples

#### Example 1 - Basic Usage
```json
{
  "primitiveName": "yes"
}
```

#### Example 2 - Request Form
```http
GET /access/accepteula2?magic=<magic2-token>&accept=yes
Authorization: Basic <api_user:api_pass>
```
