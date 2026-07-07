# access/uploadtemplate

**Category**: templates  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Install-Template`

## Description

Installs template.

## Endpoint

```text
POST https://<host>:<port>/access/uploadtemplate?path=<path>
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `path` | string | Yes | Local file path supplied to the PowerShell cmdlet; represented as uploaded or downloaded content in REST usage. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST --data-binary "@template.tmpl" "https://10.0.0.69:443/access/uploadtemplate?path=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- uploadtemplate operation completed -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"uploadtemplate","path":"example"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## Live Validation (2026-06-16)

- Successfully uploaded `exchange_2019_core_without_esp.tmpl` on firmware 7.2.63.x
- Response: `Installed 5 new Kemp certified templates.`
- A single `.tmpl` file can contain multiple templates (the Exchange 2019 bundle has 5)
- The `path` parameter in the endpoint docs is misleading — use `--data-binary @<file>` with no query params
- No `Content-Type` header is required — raw binary POST body works
- **This is the only post-license operation that requires APIv1.** Binary file uploads are
  not supported by the APIv2 JSON interface. Use `POST /access/uploadtemplate` with Basic Auth.
- Once the template is uploaded, creating VS from it can be done via APIv2:
  `{"cmd":"addvs","vs":"10.0.0.100","port":"443","prot":"tcp","template":"Exchange 2019 HTTPS re-encrypted"}`

```bash
# Correct usage (APIv1 - binary upload):
curl -sk -u "bal:PASS" -X POST --data-binary "@exchange_2019_core_without_esp.tmpl" \
  "https://10.0.0.14/access/uploadtemplate"

# Verify:
curl -sk -u "bal:PASS" "https://10.0.0.14/access/listtemplates"
```

## See Also

- `access/deltemplate` — removes template
- `access/listtemplates` — lists installed templates
- `access/addvs` — creates a VS from an installed template via the `template` parameter
- `access/listtemplates` — retrieves template
