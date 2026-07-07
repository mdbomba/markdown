# access/addacmecert

**Category**: certificates  
**Firmware**: 7.2.61+ (from Postman APIv1 collection)  
**Source**: Postman APIv1 Documentation 7.2.61

## Description

To request a new ACME certificate, run the addacmecert command using cert, cn, vid (Virtual Service ID), and acmetype as mandatory parameters.

## Endpoints

### APIv2 (Recommended)

```bash
curl -sk -X POST "https://<host>:<port>/accessv2" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"addacmecert", "param": "value"}'
```

### APIv1 (Fallback)

```text
GET https://<host>:<port>/access/addacmecert?cert=<value>&cn=<value>&vsid=<value>&keysize=<value>&acmetype=<value>
```

## HTTP Method

- **APIv2**: `POST` (JSON body)
- **APIv1**: `GET` (query-string)

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `cert` | string | See notes | See description |
| `cn` | string | See notes | See description |
| `vsid` | string | See notes | See description |
| `keysize` | string | See notes | See description |
| `acmetype` | string | See notes | See description |

## Example Request (APIv1)

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.14/access/addacmecert?cert=Identifier&cn=example4.ddns.net&vsid=1&keysize=2048&acmetype=1"
```

## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.14/accessv2" \
  -d '{"apiuser": "bal", "apipass": "PASSWORD", "cmd": "addacmecert", "cert": "Identifier", "cn": "example4.ddns.net", "vsid": "1", "keysize": "2048", "acmetype": "1"}'
```

## Notes

- This command was added/renamed in firmware 7.2.61 (not present in the LTSF 7.2.54 branch).
- Extracted from the official Progress Kemp Postman APIv1 collection (7.2.61).

## See Also

- Related commands in the `certificates` category
