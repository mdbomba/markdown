# access/modvs

**Category**: virtual services  
**Firmware tested**: 7.2.54.12.22642.RELEASE  
**PS Cmdlet**: `Set-AdcSubVirtualService`

## Description

Modifies the settings of an existing virtual service.

## Endpoint

```text
POST https://<host>:<port>/access/modvs?addvia=<addvia>&userpwdexpirywarn=<userpwdexpirywarn>&userpwdexpirywarndays=<userpwdexpirywarndays>[&...]
```

## HTTP Method

`POST` — write/modify operation.

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `addvia` | integer | No | Addvia value for this command. |
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
| `cookie` | string | No | Cookie value for this command. |
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
| `schedule` | string | No | Schedule value for this command. |
| `serverinit` | integer | No | Serverinit value for this command. |
| `standbyaddr` | string | No | Standbyaddr IP address. |
| `standbyport` | string | No | Standbyport port number. |
| `transactionlimit` | integer | No | Transactionlimit value for this command. |
| `transparent` | boolean | No | Transparent value for this command. |
| `subnetoriginating` | boolean | No | Subnetoriginating value for this command. |
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
| `serverfbapath` | string | No | Serverfbapath value for this command. |
| `serverfbapost` | string | No | Serverfbapost value for this command. |
| `tokenserverfqdn` | string | No | Tokenserverfqdn fully qualified domain name. |
| `addauthheader` | string | No | Addauthheader value for this command. |
| `verifybearer` | boolean | No | Verifybearer value for this command. |
| `bearercertificatename` | string | No | Bearercertificatename value for this command. |
| `bearertext` | string | No | Bearertext value for this command. |
| `singlesignonmessage` | string | No | Singlesignonmessage value for this command. |
| `intercept` | boolean | No | Intercept value for this command. |
| `interceptopts` | string | No | Interceptopts value for this command. |
| `interceptrules` | string | No | Interceptrules value for this command. |
| `interceptpostothercontenttypes` | string | No | Interceptpostothercontenttypes value for this command. |
| `alertthreshold` | string | No | Alertthreshold value for this command. |
| `captcha` | boolean | No | Captcha value for this command. |
| `captchapublickey` | string | No | Captchapublickey value for this command. |
| `captchaprivatekey` | string | No | Captchaprivatekey value for this command. |
| `captchaaccessurl` | string | No | Captchaaccessurl value for this command. |
| `captchaverifyurl` | string | No | Captchaverifyurl value for this command. |
| `weight` | integer | No | Weight value for this command. |
| `limit` | integer | No | Limit value for this command. |
| `critical` | boolean | No | Critical value for this command. |
| `bandwidth` | integer | No | Bandwidth value for this command. |
| `refreshpersist` | boolean | No | Refreshpersist value for this command. |
| `serverfbausernameonly` | string | No | Serverfbausernameonly value for this command. |
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
| `non_local` | string | No | Required literal value `1`. Non Local value for this command. |

## Example Request

```bash
curl -sk -u "bal:PASSWORD" -X POST "https://10.0.0.69:443/access/modvs?addvia=example&userpwdexpirywarn=example&userpwdexpirywarndays=example"
```

## Example Response (XML)

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<Response stat="200" code="ok">
  <Success>
    <Data>
      <!-- modvs operation completed -->
    </Data>
  </Success>
</Response>
```

## Notes

- API v1 responses are XML. Do not expect JSON payloads from the main response body.
- The reference guide shows multiple endpoint forms for this command, including alternate addressing by ID or name where applicable.
- Although the legacy API is query-string driven, document new automation as a write operation because it changes appliance state.

## See Also

- `access/showvs` — retrieves detailed configuration and runtime status for one virtual service
- `access/addvs` — creates a new virtual service and applies any supplied settings during creation
- `access/delvs` — deletes an existing virtual service
