# access/readeula

## `primitiveName`

**Type:** `string`  
**Required:** No  
**Default:** `N/A`  

### Description
Reads EULA state and returns the first `Magic` token when acceptance is required.

---

### Allowed Values / Options

| Value | Description |
|-------|-------------|
| `N/A` | No request primitive is provided in current usage. |

> **Note:** If `Magic` is absent, script treats EULA as already handled or unavailable.

---

### Constraints
- Requires valid API basic authentication.
- XML response is expected by script parsing logic.
- A non-empty `Magic` token is required for the next EULA call.

---

### Behavior Rules
- If omitted: no primitive payload is needed.
- What overrides this field: not applicable.
- Interactions with other parameters: output `Magic` is required by `access/accepteula`.

### Live Validation (2026-05-28)
- Endpoint returned `code="ok"` on `10.0.0.69`.
- Response included a non-empty `Magic` UUID token.
- Response also contained large encoded EULA HTML content.
- PS module equivalent: `Read-LicenseEULA` (`$lma0 = Read-LicenseEULA -LoadBalancer $FQDN -Credential $creds`)
- PS module extracts magic as: `$magicString = $lma0.Data.EULA.MagicString`

### Notes
- Called before any EULA acceptance regardless of license source (ONLINE, ONLINE-SPLA, LOCAL-SPLA, LOCAL-MELA).
- No parameters required — credentials are passed via HTTP Basic Auth.
- The large EULA HTML body in the response can be ignored; only the `Magic` token is needed.

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
GET /access/readeula
Authorization: Basic <api_user:api_pass>
```
