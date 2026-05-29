# access/addlecert

**Category**: certificates  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Request-NewLECertificate`

## Description

Handles new lecertificate.

## Endpoint

```text
POST https://<host>:<port>/access/addlecert?cert=<cert>&vid=<vid>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `cert` | string | Yes | Cert value for this command. |
| `vid` | string | Yes | Vid identifier. |
| `country` | string | No | Country value for this command. |
| `state` | string | No | State value for this command. |
| `city` | string | No | City value for this command. |
| `company` | string | No | Company value for this command. |
| `organization` | string | No | Organization value for this command. |
| `email` | string | No | Email value for this command. |
| `san1` | string | No | San1 value for this command. |
| `san2` | string | No | San2 value for this command. |
| `san3` | string | No | San3 value for this command. |
| `san4` | string | No | San4 value for this command. |
| `san5` | string | No | San5 value for this command. |
| `san6` | string | No | San6 value for this command. |
| `san7` | string | No | San7 value for this command. |
| `san8` | string | No | San8 value for this command. |
| `san9` | string | No | San9 value for this command. |
| `san10` | string | No | San10 value for this command. |
| `vid1` | string | No | Vid1 value for this command. |
| `vid2` | string | No | Vid2 value for this command. |
| `vid3` | string | No | Vid3 value for this command. |
| `vid4` | string | No | Vid4 value for this command. |
| `vid5` | string | No | Vid5 value for this command. |
| `vid6` | string | No | Vid6 value for this command. |
| `vid7` | string | No | Vid7 value for this command. |
| `vid8` | string | No | Vid8 value for this command. |
| `vid9` | string | No | Vid9 value for this command. |
| `vid10` | string | No | Vid10 value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/addlecert?cert=example&vid=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- addlecert operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- The reference guide shows multiple endpoint forms for this command, including alternate addressing by ID or name where applicable.
- Certificate and licensing workflows can take noticeably longer than simple queries. A client timeout of `max_time=60` is recommended.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/dellecert` — removes lecertificate
- `access/listlecert` — lists Let's Encrypt certificates known to the appliance
