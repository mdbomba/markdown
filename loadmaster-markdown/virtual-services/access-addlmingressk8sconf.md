# access/addlmingressk8sconf

**Category**: virtual-services  
**Firmware**: 7.2.61+ (from Postman APIv1 collection)  
**Source**: Postman APIv1 Documentation 7.2.61

## Description

To upload a Kube config file to the LoadMaster, run the addlmingressk8sconf command.

## Endpoints

### APIv2 (Recommended)

```bash
curl -sk -X POST "https://<host>:<port>/accessv2" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"addlmingressk8sconf"}'
```

### APIv1 (Fallback)

```text
POST https://<host>:<port>/access/addlmingressk8sconf
```

## HTTP Method

- **APIv2**: `POST` (JSON body)
- **APIv1**: `POST` (query-string)

## Parameters

None — this endpoint does not take query parameters.

## Example Request (APIv1)

```bash
curl -sk -u "bal:PASSWORD" "https://10.0.0.14/access/addlmingressk8sconf"
```

## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.14/accessv2" \
  -d '{"apiuser": "bal", "apipass": "PASSWORD", "cmd": "addlmingressk8sconf"}'
```

## Notes

- This command was added/renamed in firmware 7.2.61 (not present in the LTSF 7.2.54 branch).
- Extracted from the official Progress Kemp Postman APIv1 collection (7.2.61).

## See Also

- Related commands in the `virtual-services` category
