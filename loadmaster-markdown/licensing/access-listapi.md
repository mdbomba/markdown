# access/listapi

## `primitiveName`

**Type:** `string`  
**Required:** No  
**Default:** `N/A`  

### Description
This endpoint lists available API primitives. In the licensing script, presence of `get` in the response is used as a signal that the appliance is already licensed.

---

### Allowed Values / Options

| Value | Description |
|-------|-------------|
| `N/A` | No request primitive is provided in current usage. |

> **Note:** Behavior depends on appliance state. Response parsing is done against XML tags like `<cmd>`.

---

### Constraints
- Requires valid API basic authentication.
- No query string parameters in current usage.
- On unlicensed systems, command list is licensing-focused and may not include `get`.

---

### Behavior Rules
- If omitted: no primitive payload is needed.
- What overrides this field: not applicable.
- Interactions with other parameters: used before EULA and licensing flow to determine whether to continue.

### Live Validation (2026-05-28)
- Endpoint returned `code="ok"` on `10.0.0.69`.
- Observed commands included: `spla_license`, `alsilicensetypes`, `alsilicense`, `readeula`, `accepteula`,
  `accepteula2`, `set_initial_passwd`, `aslactivate`, `aslgetlicensetypes`, `aslautoadd`,
  `aslautoaddapikey`, `accesskey`, `addapikey`, `license`, `listapi`, `reboot`.
- **Important:** `listapi` does NOT contain `<cmd>get</cmd>` on firmware `7.2.54.x`.
  The correct licensed-state check is `access/get?param=version` with `New_Api_Pass` — `code=ok` means licensed.
- PS module equivalent: `Test-LMServerConnection` (polls until appliance is reachable, separate from listapi).

### Notable commands in listapi (firmware 7.2.54.x)
| Command | Purpose |
|---------|---------|
| `spla_license` | SPLA (Service Provider) online licensing — SPLA firmware builds only |
| `aslactivate` | On-premise ASL licensing (LOCAL-SPLA / LOCAL-MELA flows) |
| `aslgetlicensetypes` | Query license types available from ASL host |
| `alsilicense` | ALSI online licensing (ONLINE / ONLINE-SPLA flows) |
| `alsilicensetypes` | Query license types available from Progress portal |
| `accesskey` | Retrieve appliance access key |
| `license` | Offline BLOB-based licensing |

---

### Examples

#### Example 1 - Basic Usage
```json
{
  "primitiveName": "N/A"
}
```

#### Example 2 - Request Form
```http
GET /access/listapi
Authorization: Basic <api_user:api_pass>
```
