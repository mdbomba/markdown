# access/addvs

**Category**: virtual services  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `New-AdcVirtualService`

## Description

Creates a new virtual service and applies any supplied settings during creation.

## Endpoint

```text
POST https://<host>:<port>/access/addvs?vs=<vs>&port=<port>&prot=<prot>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `vs` | string | Yes | Virtual service IP address or internal virtual service identifier, depending on the command form. |
| `port` | integer | Yes | Virtual service port number. |
| `prot` | string | Yes | Virtual service protocol, typically `tcp` or `udp`. |
| `addvia` | integer | No | Addvia value for this command. |
| `template` | string | No | Template name to upload, list, apply, or delete. |
| `cache` | boolean | No | Cache value for this command. |
| `certfile` | array | No | Certfile value for this command. |
| `intermediatecerts` | array | No | Intermediatecerts value for this command. |
| `userpwdexpirywarn` | boolean | No | Userpwdexpirywarn value for this command. |
| `userpwdexpirywarndays` | integer | No | Userpwdexpirywarndays value for this command. |
| `checktype` | string | No | Checktype value for this command. |
| `checkhost` | string | No | Checkhost host value. |
| `checkpattern` | string | No | Checkpattern value for this command. |
| `checkurl` | string | No | Checkurl value for this command. |
| `checkheaders` | string | No | Checkheaders value for this command. |
| `ldapendpoint` | string | No | Ldapendpoint value for this command. |
| `matchlen` | string | No | Matchlen value for this command. |
| `checkuse1_1` | integer | No | Checkuse1 1 value for this command. |
| `chkinterval` | integer | No | Chkinterval value for this command. |
| `chktimeout` | integer | No | Chktimeout value for this command. |
| `chkretrycount` | integer | No | Chkretrycount value for this command. |
| `checkport` | integer | No | Checkport port number. |
| `enhancedhealthchecks` | boolean | No | Enhancedhealthchecks value for this command. |
| `rsminimum` | integer | No | Rsminimum value for this command. |
| `clientcert` | integer | No | Clientcert value for this command. |
| `compress` | boolean | No | Compress value for this command. |
| `cookie` | string | No | Cookie value for this command. |
| `cachepercent` | integer | No | Cachepercent value for this command. |
| `defaultgw` | string | No | Defaultgw value for this command. |
| `enable` | boolean | No | Boolean-style enable flag used by the endpoint. |
| `errorcode` | string | No | Errorcode value for this command. |
| `errorurl` | string | No | Errorurl value for this command. |
| `portfollow` | integer | No | Portfollow port number. |
| `forcel7` | boolean | No | Forcel7 value for this command. |
| `idletime` | integer | No | Idletime value for this command. |
| `localbindaddrs` | string | No | Localbindaddrs value for this command. |
| `vstype` | string | No | Vstype value for this command. |
| `nickname` | string | No | Nickname value for this command. |
| `persist` | string | No | Persist value for this command. |
| `persisttimeout` | integer | No | Persisttimeout value for this command. |
| `querytag` | string | No | Querytag value for this command. |
| `cipherset` | string | No | Cipher Set value for this command. |
| `passcipher` | boolean | No | Passcipher value for this command. |
| `passsni` | boolean | No | Passsni value for this command. |
| `sslreencrypt` | boolean | No | Sslreencrypt value for this command. |
| `sslreverse` | boolean | No | Sslreverse value for this command. |
| `sslrewrite` | string | No | Sslrewrite value for this command. |
| `reversesnihostname` | string | No | Reversesnihostname host value. |
| `schedule` | string | No | Schedule value for this command. |
| `serverinit` | integer | No | Serverinit value for this command. |
| `sslacceleration` | boolean | No | Sslacceleration value for this command. |
| `standbyaddr` | string | No | Standbyaddr IP address. |
| `standbyport` | string | No | Standbyport port number. |
| `transactionlimit` | integer | No | Transactionlimit value for this command. |
| `transparent` | boolean | No | Transparent value for this command. |
| `subnetoriginating` | boolean | No | Subnetoriginating value for this command. |
| `useforsnat` | boolean | No | Useforsnat value for this command. |
| `qos` | string | No | Qos value for this command. |
| `checkuseget` | string | No | Checkuseget value for this command. |
| `verify` | integer | No | Verify value for this command. |
| `extrahdrkey` | string | No | Extrahdrkey value for this command. |
| `extrahdrvalue` | string | No | Extrahdrvalue value for this command. |
| `allowedhosts` | string | No | Allowedhosts host value. |
| `alloweddirectories` | string | No | Alloweddirectories value for this command. |
| `excludeddirectories` | string | No | Excludeddirectories value for this command. |
| `allowedgroups` | string | No | Allowedgroups value for this command. |
| `groupsids` | string | No | Groupsids value for this command. |
| `steeringgroups` | string | No | Steeringgroups value for this command. |
| `includenestedgroups` | boolean | No | Includenestedgroups value for this command. |
| `multidomainpermittedgroups` | boolean | No | Multidomainpermittedgroups value for this command. |
| `displaypubpriv` | boolean | No | Displaypubpriv value for this command. |
| `disablepasswordform` | boolean | No | Password value used by this command. |
| `domain` | string | No | Domain name targeted by the command. |
| `altdomains` | string | No | Altdomains value for this command. |
| `logoff` | string | No | Logoff value for this command. |
| `esplogs` | integer | No | Esplogs value for this command. |
| `smtpalloweddomains` | string | No | Smtpalloweddomains value for this command. |
| `espenabled` | boolean | No | Espenabled value for this command. |
| `userpwdchangeurl` | string | No | Userpwdchangeurl value for this command. |
| `userpwdchangemsg` | string | No | Userpwdchangemsg value for this command. |
| `securityheaderoptions` | integer | No | Securityheaderoptions value for this command. |
| `inputauthmode` | integer | No | Inputauthmode value for this command. |
| `outconf` | string | No | Outconf value for this command. |
| `outputauthmode` | integer | No | Outputauthmode value for this command. |
| `starttlsmode` | integer | No | Starttlsmode value for this command. |
| `extraports` | string | No | Extraports port number. |
| `altaddress` | string | No | Altaddress IP address. |
| `multiconnect` | boolean | No | Multiconnect value for this command. |
| `singlesignondir` | string | No | Singlesignondir value for this command. |
| `ocspverify` | string | No | Ocspverify value for this command. |
| `followvsid` | integer | No | Followvsid identifier. |
| `tlstype` | integer | No | Tlstype value for this command. |
| `checkpostdata` | string | No | Checkpostdata value for this command. |
| `checkcodes` | string | No | Checkcodes value for this command. |
| `preprocprecedence` | string | No | Preprocprecedence value for this command. |
| `preprocprecedencepos` | integer | No | Preprocprecedencepos value for this command. |
| `requestprecedence` | string | No | Requestprecedence value for this command. |
| `requestprecedencepos` | integer | No | Requestprecedencepos value for this command. |
| `responseprecedence` | string | No | Responseprecedence value for this command. |
| `responseprecedencepos` | integer | No | Responseprecedencepos value for this command. |
| `rsruleprecedence` | string | No | Rsruleprecedence value for this command. |
| `rsruleprecedencepos` | integer | No | Rsruleprecedencepos value for this command. |
| `matchbodyprecedence` | string | No | Matchbodyprecedence value for this command. |
| `matchbodyprecedencepos` | integer | No | Matchbodyprecedencepos value for this command. |
| `needhostname` | boolean | No | Needhostname host value. |
| `copyhdrfrom` | string | No | Copyhdrfrom value for this command. |
| `copyhdrto` | string | No | Copyhdrto value for this command. |
| `singlesignonmessage` | string | No | Singlesignonmessage value for this command. |
| `verifybearer` | boolean | No | Verifybearer value for this command. |
| `bearercertificatename` | string | No | Bearercertificatename value for this command. |
| `bearertext` | string | No | Bearertext value for this command. |
| `bandwidth` | integer | No | Bandwidth value for this command. |
| `refreshpersist` | boolean | No | Refreshpersist value for this command. |
| `connsperseclimit` | integer | No | Connsperseclimit value for this command. |
| `requestsperseclimit` | integer | No | Requestsperseclimit value for this command. |
| `maxconnslimit` | integer | No | Maxconnslimit value for this command. |
| `interceptmode` | integer | No | Interceptmode value for this command. |
| `owaspopts` | string | No | Owaspopts value for this command. |
| `blockingparanoia` | integer | No | Blockingparanoia value for this command. |
| `executingparanoia` | integer | No | Executingparanoia value for this command. |
| `anomalyscoringthreshold` | integer | No | Anomalyscoringthreshold value for this command. |
| `pcrelimit` | integer | No | Pcrelimit value for this command. |
| `jsondlimit` | integer | No | Jsondlimit value for this command. |
| `ipreputationblocking` | boolean | No | Ipreputationblocking value for this command. |
| `rulesets` | string | No | Rulesets value for this command. |
| `customrules` | string | No | Customrules value for this command. |
| `excludedworkloads` | string | No | Excludedworkloads value for this command. |
| `disabledrules` | string | No | Disabledrules flag. |
| `blockedcountries` | string | No | Blockedcountries value for this command. |
| `auditparts` | string | No | Auditparts value for this command. |
| `postothercontenttypes` | string | No | Postothercontenttypes value for this command. |
| `interceptopts` | string | No | Interceptopts value for this command. |
| `interceptrules` | string | No | Interceptrules value for this command. |
| `interceptpostothercontenttypes` | string | No | Interceptpostothercontenttypes value for this command. |
| `alertthreshold` | string | No | Alertthreshold value for this command. |
| `samesite` | integer | No | Samesite value for this command. |
| `bodylimit` | integer | No | Bodylimit value for this command. |
| `tls13cipherset` | string | No | Tls13cipherset value for this command. |
| `responsestatusremap` | boolean | No | Responsestatusremap value for this command. |
| `responseremapcodemap` | string | No | Responseremapcodemap value for this command. |
| `responseremapmsgmap` | string | No | Responseremapmsgmap value for this command. |
| `responseremapmsgformat` | string | No | Responseremapmsgformat value for this command. |
| `httpreschedule` | boolean | No | Httpreschedule value for this command. |
| `adaptiveinterval` | integer | No | Adaptiveinterval value for this command. |
| `adaptiveurl` | string | No | Adaptiveurl value for this command. |
| `adaptiveport` | integer | No | Adaptiveport port number. |
| `adaptiveminpercent` | integer | No | Adaptiveminpercent value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/addvs?vs=192.0.2.10&port=443&prot=tcp"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- addvs operation completed -->
    </Data>
  </Success>
</Response>
```


## Example Request (APIv2)

```bash
curl -sk -X POST "https://10.0.0.69:443/accessv2" \
  -H "Content-Type: application/json" \
  -d '{"apiuser":"bal","apipass":"PASSWORD","cmd":"addvs","vs":"10.0.0.50","port":"443","prot":"tcp","addvia":"1","template":"example","cache":"1","certfile":"example","intermediatecerts":"example","userpwdexpirywarn":"1","userpwdexpirywarndays":"1","checktype":"example","checkhost":"example","checkpattern":"example","checkurl":"example","checkheaders":"example","ldapendpoint":"example","matchlen":"example","checkuse1_1":"1","chkinterval":"1","chktimeout":"1","chkretrycount":"1","checkport":"1","enhancedhealthchecks":"1","rsminimum":"1","clientcert":"1","compress":"1","cookie":"example","cachepercent":"1","defaultgw":"example","enable":"1","errorcode":"example","errorurl":"example","portfollow":"1","forcel7":"1","idletime":"1","localbindaddrs":"example","vstype":"example","nickname":"example","persist":"example","persisttimeout":"1","querytag":"example","cipherset":"example","passcipher":"1","passsni":"1","sslreencrypt":"1","sslreverse":"1","sslrewrite":"example","reversesnihostname":"example","schedule":"example","serverinit":"1","sslacceleration":"1","standbyaddr":"example","standbyport":"example","transactionlimit":"1","transparent":"1","subnetoriginating":"1","useforsnat":"1","qos":"example","checkuseget":"example","verify":"1","extrahdrkey":"example","extrahdrvalue":"example","allowedhosts":"example","alloweddirectories":"example","excludeddirectories":"example","allowedgroups":"example","groupsids":"example","steeringgroups":"example","includenestedgroups":"1","multidomainpermittedgroups":"1","displaypubpriv":"1","disablepasswordform":"1","domain":"example.com","altdomains":"example","logoff":"example","esplogs":"1","smtpalloweddomains":"example","espenabled":"1","userpwdchangeurl":"example","userpwdchangemsg":"example","securityheaderoptions":"1","inputauthmode":"1","outconf":"example","outputauthmode":"1","starttlsmode":"1","extraports":"example","altaddress":"10.0.0.50","multiconnect":"1","singlesignondir":"example","ocspverify":"example","followvsid":"1","tlstype":"1","checkpostdata":"example","checkcodes":"example","preprocprecedence":"example","preprocprecedencepos":"1","requestprecedence":"example","requestprecedencepos":"1","responseprecedence":"example","responseprecedencepos":"1","rsruleprecedence":"example","rsruleprecedencepos":"1","matchbodyprecedence":"example","matchbodyprecedencepos":"1","needhostname":"1","copyhdrfrom":"example","copyhdrto":"example","singlesignonmessage":"example","verifybearer":"1","bearercertificatename":"example","bearertext":"example","bandwidth":"1","refreshpersist":"1","connsperseclimit":"1","requestsperseclimit":"1","maxconnslimit":"1","interceptmode":"1","owaspopts":"example","blockingparanoia":"1","executingparanoia":"1","anomalyscoringthreshold":"1","pcrelimit":"1","jsondlimit":"1","ipreputationblocking":"1","rulesets":"example","customrules":"example","excludedworkloads":"example","disabledrules":"example","blockedcountries":"example","auditparts":"example","postothercontenttypes":"example","interceptopts":"example","interceptrules":"example","interceptpostothercontenttypes":"example","alertthreshold":"example","samesite":"1","bodylimit":"1","tls13cipherset":"example","responsestatusremap":"1","responseremapcodemap":"example","responseremapmsgmap":"example","responseremapmsgformat":"example","httpreschedule":"1","adaptiveinterval":"1","adaptiveurl":"example","adaptiveport":"1","adaptiveminpercent":"1"}'
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## Creating VS from Templates

The `template` parameter applies a pre-configured template to the new virtual service.
Templates are uploaded via `access/uploadtemplate` and listed via `access/listtemplates`.

### Live Validation (2026-06-16)

- Template names must be **URL-encoded** (e.g., spaces become `%20`)
- A single `.tmpl` file can contain multiple templates (e.g., Exchange 2019 bundle installs 5)
- Templates that include sub-VS (content switching) create a Master VS with child sub-VS automatically
- The HTTP method is actually **GET** (not POST) despite modifying state — this is the legacy API pattern

```bash
# Upload a template file
curl -sk -u "bal:PASS" -X POST --data-binary "@exchange_2019_core_without_esp.tmpl" \
  "https://$LM_IP/access/uploadtemplate"
# Response: "Installed 5 new Kemp certified templates."

# Create VS from template (URL-encode the template name)
curl -sk -u "bal:PASS" \
  "https://$LM_IP/access/addvs?vs=10.0.0.100&port=443&prot=tcp&template=Exchange%202019%20HTTPS%20re-encrypted"
# Response: "Template VS added"

# The Exchange 2019 HTTPS re-encrypted template creates:
#   - Master VS (port 443) with 10 sub-VS for content switching
#   - HTTP Redirect VS (port 80) with 301 -> https://%h%s
#   - Sub-VS for: ActiveSync, API, Autodiscover, ECP, EWS, MAPI, OAB, OWA, PowerShell, RPC
```

### Available Exchange 2019 Templates (from .tmpl bundle)
| Template Name | Description |
|---------------|-------------|
| Exchange 2019 HTTPS Offload | SSL offload — sends HTTP to backend |
| Exchange 2019 HTTPS pass-through | SSL pass-through — no decryption |
| Exchange 2019 HTTPS re-encrypted | SSL re-encryption — decrypts and re-encrypts to backend |
| Exchange 2019 SMTP | SMTP load balancing (port 25) |
| Exchange 2019 Office Online Server | OOS on port 8443 with SSL re-encryption |

## See Also

- `access/modvs` — modifies the settings of an existing virtual service
- `access/delvs` — deletes an existing virtual service
- `access/showvs` — retrieves detailed configuration and runtime status for one virtual service
