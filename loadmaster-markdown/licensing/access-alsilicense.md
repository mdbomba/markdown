# access/alsilicense

## `kempid`

**Type:** `string`  
**Required:** Yes  
**Default:** `<none>`  

### Description
Progress account identifier used when requesting actual license installation.

---

### Allowed Values / Options

| Value | Description |
|-------|-------------|
| `<progress-user-id>` | Account user ID. |

> **Note:** Must match account used in previous license type query.

---

### Constraints
- Non-empty, valid account string.

---

### Behavior Rules
- If omitted: call fails authentication/validation.
- What overrides this field: none.
- Interactions with other parameters: tied to `password` and `lic_type_id`.

---

### Examples

#### Example 1 - Basic Usage
```json
{
  "primitiveName": "my-progress-user"
}
```

## `password`

**Type:** `string`  
**Required:** Yes  
**Default:** `<none>`  

### Description
URL-encoded Progress password used for license activation call.

---

### Allowed Values / Options

| Value | Description |
|-------|-------------|
| `<url-encoded-password>` | Password encoded with URI escaping. |

> **Note:** Encoding prevents query-string breakage with special characters.

---

### Constraints
- Must be URL-encoded.

---

### Behavior Rules
- If omitted: authentication fails.
- What overrides this field: none.
- Interactions with other parameters: must correspond to same account as `kempid`.

---

### Examples

#### Example 1 - Basic Usage
```json
{
  "primitiveName": "encoded-password-value"
}
```

## `lic_type_id`

**Type:** `string | enum`  
**Required:** Yes  
**Default:** `<none>`  

### Description
Selected license type identifier returned from `access/alsilicensetypes`.

---

### Allowed Values / Options

| Value | Description |
|-------|-------------|
| `<id>` | Selected from license type list (for example category license id). |

> **Note:** Source workflow uses interactive selection and submits the selected id.

---

### Constraints
- Must exist in response set from `access/alsilicensetypes`.

---

### Behavior Rules
- If omitted: installation call fails.
- What overrides this field: none.
- Interactions with other parameters: must be valid for `kempid` entitlement.

### Live Validation (2026-05-28)
- Calling endpoint without completing EULA flow returned `code="fail"`.
- Observed error message: `Attempt to license called out of sequence. EULA not accepted`.
- Confirms EULA acceptance is a hard prerequisite for license install.
- **Timing:** This call contacts the Progress licensing servers externally and can take
  well beyond 15 seconds to complete. Use `max_time=60` (or higher). A 0-byte response
  file indicates a timeout, not a successful license install.

---

### Examples

#### Example 1 - Basic Usage
```json
{
  "primitiveName": "1024"
}
```

#### Example 2 - Request Form
```http
GET /access/alsilicense?kempid=<id>&password=<encoded>&lic_type_id=<license-id>
Authorization: Basic <api_user:api_pass>
```
