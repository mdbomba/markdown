# access/accepteula

## `magic`

**Type:** `string`  
**Required:** Yes  
**Default:** `<none>`  

### Description
First EULA acceptance step. Uses the `Magic` token returned by `access/readeula`.

---

### Allowed Values / Options

| Value | Description |
|-------|-------------|
| `<magic-token>` | Token retrieved from `access/readeula`. |

> **Note:** Token appears to be one-time and state-dependent.

---

### Constraints
- Must be a non-empty token from a fresh `readeula` response.

---

### Behavior Rules
- If omitted: request fails to continue EULA flow.
- What overrides this field: none.
- Interactions with other parameters: generates second token for `access/accepteula2`.

---

### Examples

#### Example 1 - Basic Usage
```json
{
  "primitiveName": "magic-token-from-readeula"
}
```

## `type`

**Type:** `string | enum`  
**Required:** Yes  
**Default:** `<none>`  

### Description
License type selector used during EULA acceptance request.

---

### Allowed Values / Options

| Value | Description |
|-------|-------------|
| `free` | Free / trial license — default value set by PS module (`$global:PSDefaultParameterValues`) |
| `trial` | Alias for free trial (PS module uses `"trial"` in `master-deployment.ps1`) |
| `perm` | Permanent license |

> **Source:** `[ValidateSet("trial", "perm", "free")]` confirmed directly from PS module source
> (`Kemp.LoadBalancer.Powershell.psm1`, `Confirm-LicenseEULA` function).
> The PS module sets `"trial"` as the global default: `$global:PSDefaultParameterValues = @{"Confirm-LicenseEULA:Type"="trial"}`

---

### Constraints
- Must be one of: `free`, `trial`, `perm`
- `freemax` is **not** a valid value — returns `Unknown license model`
- Live-confirmed working value: `free` (ONLINE flow on firmware `7.2.54.x`)

---

### Behavior Rules
- If omitted: EULA step may fail or return non-success code.
- What overrides this field: server-side license catalog rules.
- Interactions with other parameters: evaluated together with `magic`.

### License Source Flows (from master-deployment.ps1 and PS module source)
The PS module defines four license source paths. The `type` value used in `accepteula` corresponds as follows:

| PS `licenseSource` | `accepteula` type | Next command | Notes |
|--------------------|-------------------|--------------|-------|
| `ONLINE` | `free`/`trial` | `alsilicense` (no orderid) | Standard online |
| `ONLINE-SPLA` | `free`/`trial` | `alsilicense` (with orderid) or `spla_license` | Service Provider online |
| `LOCAL-SPLA` | `free`/`trial` | `aslactivate` (`aslhost`, `aslport`) | On-prem ASL host |
| `LOCAL-MELA` | `free`/`trial` | `aslactivate` (`aslhost`, `aslport`) | On-prem ASL host |

> **Note:** PS module source (`Request-LicenseOnPremise`) confirms `aslhost`/`aslport` are the correct
> parameter names for on-prem licensing — not `aslipaddr` as referenced in older docs.

### Live Validation (2026-05-28)
- `access/accepteula?magic=<valid>&type=freemax` returned `code="fail"` — `Unknown license model`.
- `access/accepteula?magic=<valid>&type=free` returned `code="ok"` ✓
- No second `Magic` token is emitted when `type` is invalid.

---

### Examples

#### Example 1 - Basic Usage
```json
{
  "primitiveName": "freemax"
}
```

#### Example 2 - Request Form
```http
GET /access/accepteula?magic=<magic-token>&type=<license-type>
Authorization: Basic <api_user:api_pass>
```
