# access/setlocalreservedports

**Category**: system  
**Firmware**: 7.2.61+ (from Postman APIv1 collection)  
**Source**: Postman APIv1 Documentation 7.2.61

## Description

Specify a single port, or list of comma-separated ports, that will not be used when initiating connections to Real Servers. Some things to note about this field are as follows:

## Endpoints

### APIv2 (Recommended)

```bash
curl -sk -X POST "https://<host>:<port>/accessv2" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"setlocalreservedports", "param": "value"}'
```

### APIv1 (Fallback)

```text
GET https://<host>:<port>/access/setlocalreservedports?ports=<value>
```

## HTTP Method

- **APIv2**: `POST` (JSON body)
- **APIv1**: `GET` (query-string)

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `ports` | string | See notes | See description |

## Example Request (APIv1)

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.14/access/setlocalreservedports?ports=2034,2035"
```

## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.14/accessv2" \
  -d '{"apiuser": "bal", "apipass": "PASSWORD", "cmd": "setlocalreservedports", "ports": "2034,2035"}'
```

## Notes

- This command was added/renamed in firmware 7.2.61 (not present in the LTSF 7.2.54 branch).
- Extracted from the official Progress Kemp Postman APIv1 collection (7.2.61).

## See Also

- Related commands in the `system` category
