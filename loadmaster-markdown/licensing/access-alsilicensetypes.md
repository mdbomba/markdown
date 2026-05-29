# access/alsilicensetypes

## `kempid`

**Type:** `string`  
**Required:** Yes  
**Default:** `<none>`  

### Description
Progress account identifier used to query available license types.

---

### Allowed Values / Options

| Value | Description |
|-------|-------------|
| `<progress-user-id>` | Progress user account identifier. |

> **Note:** Authentication to this endpoint is separate from API basic auth and passed as query primitives.

---

### Constraints
- Must match a valid Progress account.

---

### Behavior Rules
- If omitted: endpoint cannot return account-specific license inventory.
- What overrides this field: none.
- Interactions with other parameters: works with `password` and optional `orderid`.

### Live Validation (2026-05-28)
- Calling endpoint without query parameters returned `code="fail"`.
- Observed error message: `kempid: String Value missing`.
- Confirms `kempid` is hard-required before credential validation continues.

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
URL-encoded Progress password associated with `kempid`.

---

### Allowed Values / Options

| Value | Description |
|-------|-------------|
| `<url-encoded-password>` | Password encoded with URI escaping. |

> **Note:** Source script encodes this value via jq `@uri` before building the URL.

---

### Constraints
- Must be URL-safe encoded.
- Must match credentials for `kempid`.

---

### Behavior Rules
- If omitted: authentication against licensing service fails.
- What overrides this field: none.
- Interactions with other parameters: evaluated with `kempid` and `orderid`.

---

### Examples

#### Example 1 - Basic Usage
```json
{
  "primitiveName": "encoded-password-value"
}
```

## `orderid`

**Type:** `string`  
**Required:** No  
**Default:** `<blank>`  

### Description
Optional Progress order identifier. Required for VLM (Virtual LoadMaster) licensing; optional for physical appliances.

---

### Allowed Values / Options

| Value | Description |
|-------|-------------|
| `<order-id>` | Pull license options tied to purchased order (e.g. `MB-VLM-500-20`) |
| `<blank>` | Returns trial-compatible license types only |

> **Note:** In the script, this primitive is appended only when non-empty.

---

### Constraints
- Should match existing order format in Progress backend.
- Required for VLM licensing — without it only trial types are returned.

---

### Behavior Rules
- If omitted: server may return only trial-compatible types.
- What overrides this field: account entitlements.
- Interactions with other parameters: filtered by `kempid` identity.

### PS Module Cross-reference
- `ONLINE` flow: `Request-LicenseOnline -KempId $kempId -Password $kempIdPassword` (no orderid)
- `ONLINE-SPLA` flow: `Request-LicenseOnline -KempId $kempId -Password $kempIdPassword -OrderId $kempIdOrderNumber`

---

### Examples

#### Example 1 - Basic Usage
```json
{
  "primitiveName": "MB-VLM-500-20"
}
```

#### Example 2 - Request Form
```http
GET /access/alsilicensetypes?kempid=<id>&password=<encoded>&orderid=<optional>
Authorization: Basic <api_user:api_pass>
```
