# Certificates & TLS

TLS certificate management including upload, deletion, cipher set configuration, ACME (Let's Encrypt / DigiCert) automation, and OCSP stapling.

## Commands (23 + 14 ACME)

| Command | Description |
|---------|-------------|
| [`access/addcert`](access-addcert.md) | Uploads a certificate bundle to the appliance certificate store |
| [`access/delcert`](access-delcert.md) | Removes TLS certificate |
| [`access/listcert`](access-listcert.md) | Lists certificates stored on the appliance |
| [`access/readcert`](access-readcert.md) | Retrieves the details or contents of a stored certificate |
| [`access/backupcert`](access-backupcert.md) | Downloads a certificate backup from the appliance |
| [`access/restorecert`](access-restorecert.md) | Restores a certificate backup onto the appliance |
| [`access/addintermediate`](access-addintermediate.md) | Creates TLS intermediate certificate |
| [`access/delintermediate`](access-delintermediate.md) | Removes TLS intermediate certificate |
| [`access/listintermediate`](access-listintermediate.md) | Retrieves TLS intermediate certificate |
| [`access/readintermediate`](access-readintermediate.md) | Retrieves TLS intermediate certificate |
| [`access/addlecert`](access-addlecert.md) | Handles new lecertificate |
| [`access/dellecert`](access-dellecert.md) | Removes lecertificate |
| [`access/listlecert`](access-listlecert.md) | Lists Let's Encrypt certificates known to the appliance |
| [`access/getlecert`](access-getlecert.md) | Retrieves details for a Let's Encrypt certificate |
| [`access/renewlecert`](access-renewlecert.md) | Requests renewal of an existing Let's Encrypt certificate |
| [`access/registerleaccount`](access-registerleaccount.md) | Registers a Let's Encrypt account for certificate automation |
| [`access/fetchleaccount`](access-fetchleaccount.md) | Retrieves stored Let's Encrypt account details |
| [`access/leaccountinfo`](access-leaccountinfo.md) | Retrieves leaccount info |
| [`access/getcipherset`](access-getcipherset.md) | Retrieves TLS cipher set |
| [`access/modifycipherset`](access-modifycipherset.md) | Updates TLS cipher set |
| [`access/delcipherset`](access-delcipherset.md) | Can be used to delete an existing custom cipher set |
| [`access/hsminfo`](access-hsminfo.md) | Handles hsminfo |
| [`access/hsmsmartinfo`](access-hsmsmartinfo.md) | Handles hsmsmartinfo |

### ACME Certificate Management (7.2.61+ — replaces legacy Let's Encrypt commands)

| Command | Description |
|---------|-------------|
| [`access/registeracmeaccount`](access-registeracmeaccount.md) | Register an ACME account (Let's Encrypt or DigiCert) |
| [`access/acmeaccountinfo`](access-acmeaccountinfo.md) | Get ACME account information |
| [`access/addacmecert`](access-addacmecert.md) | Request a new ACME certificate (including wildcard) |
| [`access/renewacmecert`](access-renewacmecert.md) | Renew an existing ACME certificate |
| [`access/delacmecert`](access-delacmecert.md) | Delete an ACME certificate |
| [`access/listacmecert`](access-listacmecert.md) | List all ACME certificates |
| [`access/getacmecert`](access-getacmecert.md) | Get details of a specific ACME certificate |
| [`access/getacmedirectoryurl`](access-getacmedirectoryurl.md) | Get the ACME directory URL |
| [`access/setacmedirectoryurl`](access-setacmedirectoryurl.md) | Set the ACME directory URL |
| [`access/getacmerenewperiod`](access-getacmerenewperiod.md) | Get the auto-renew period |
| [`access/setacmerenewperiod`](access-setacmerenewperiod.md) | Set the auto-renew period (1-60 days) |
| [`access/setacmekid`](access-setacmekid.md) | Set DigiCert Key ID |
| [`access/setacmehmac`](access-setacmehmac.md) | Set DigiCert HMAC key |
| [`access/delacmeconfig`](access-delacmeconfig.md) | Delete ACME configuration (reset) |

> **Note:** The legacy `addlecert`, `renewlecert`, `dellecert`, `listlecert`, `getlecert`,
> `leaccountinfo`, `registerleaccount` commands are deprecated in 7.2.61+.
> Use the `acme*` equivalents above which support both Let's Encrypt and DigiCert.
