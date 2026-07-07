# access/useraddlocal

**Category**: users  
**Firmware tested**: 7.2.63.2.RELEASE  
**PS Cmdlet**: `New-SecUser`

## Description

Creates a local admin user account on the LoadMaster.

## Endpoint

```text
GET https://<host>:<port>/access/useraddlocal?user=<user>&password=<pass>&perms=<level>
```

## HTTP Method

`GET` — despite modifying state, uses GET with query-string parameters (legacy API pattern).

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `user` | string | Yes | Username for the new local admin account |
| `password` | string | No | Password for the account (omit for cert-only user) |
| `radius` | string | No | Set to `n` to skip RADIUS association |
| `nopass` | string | No | Set to `yes` to create cert-based account (no password) |
| `perms` | string | No | Permission level: `1`=read-only, `2`=read-write, `3`=full admin. Set via `usersetperms` if not specified here |

## Example Request

```bash
# Create password-based admin with full permissions
curl -sk -u "bal:PASSWORD" "https://10.0.0.14:443/access/useraddlocal?user=admin-mike&password=CHANGE_ME_PASSWORD&radius=n&perms=3"

# Create certificate-based admin (no password)
curl -sk -u "bal:PASSWORD" "https://10.0.0.14:443/access/useraddlocal?user=Mike@KEMPTECH.BIZ&nopass=yes"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
<Success>Command completed ok</Success>
</Response>
```

## Live Validation (2026-06-16)

- Successfully created password-based admin `admin-mike` with `perms=3` (full admin) on firmware 7.2.63.x
- The `perms` parameter can be passed during creation to avoid a separate `usersetperms` call
- For certificate-based users (CAC/PIV): use `nopass=yes` and the `user` field should be the certificate Principal Name (case-sensitive)
- After creating a cert-based user, assign permissions with: `access/usersetperms?user=<name>&perms=root`
- The STIG script uses `perms=root` (equivalent to full admin / level 3)
- Verified that the new account can immediately authenticate to the API


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"useraddlocal","user":"ExampleUser","password":"example","radius":"example","nopass":"example","perms":"example"}'
```

## Notes

- Username is case-sensitive for certificate-based accounts
- The `radius=n` parameter explicitly disables RADIUS association for the account
