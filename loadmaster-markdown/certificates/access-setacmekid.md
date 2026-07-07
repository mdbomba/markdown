# access/setacmekid

**Category**: certificates  
**Firmware**: 7.2.61+ (from Postman APIv1 collection)  
**Source**: Postman APIv1 Documentation 7.2.61

## Description

The account Key ID is used for identification on the DigiCert account.

## Endpoints

### APIv2 (Recommended)

```bash
curl -sk -X POST "https://<host>:<port>/accessv2" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"setacmekid", "param": "value"}'
```

### APIv1 (Fallback)

```text
GET https://<host>:<port>/access/setacmekid?kid=<value>&acmetype=<value>
```

## HTTP Method

- **APIv2**: `POST` (JSON body)
- **APIv1**: `GET` (query-string)

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `kid` | string | See notes | See description |
| `acmetype` | string | See notes | See description |

## Example Request (APIv1)

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.14/access/setacmekid?kid=1&acmetype=2"
```

## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.14/accessv2" \
  -d '{"apiuser": "bal", "apipass": "PASSWORD", "cmd": "setacmekid", "kid": "1", "acmetype": "2"}'
```

## Notes

- This command was added/renamed in firmware 7.2.61 (not present in the LTSF 7.2.54 branch).
- Extracted from the official Progress Kemp Postman APIv1 collection (7.2.61).

## See Also

- Related commands in the `certificates` category
