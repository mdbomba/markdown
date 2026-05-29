# LoadMaster API Parameter Reference

Live data from `access/getall` on firmware `7.2.54.12.22642.RELEASE`.
Use with `access/get?param=<name>` and `access/set?param=<name>&value=<value>`.

## System
| Parameter | Current Value | Description |
|-----------|--------------|-------------|
| hostname | lb100 | Appliance hostname |
| version | 7.2.54.12.22642.RELEASE | Firmware version (read-only) |
| serialnumber | 1350841 | Serial number (read-only) |
| boottime | — | Last boot time (read-only) |
| activetime | — | Active since (read-only) |
| time | — | Current time (read-only) |
| autosave | yes | Auto-save configuration |
| MinPassword | 8 | Minimum password length |
| extendedperms | no | Extended API permissions |
| EnableIsetupCli | yes | Enable isetup CLI |

## Network
| Parameter | Current Value | Description |
|-----------|--------------|-------------|
| dfltgw | 10.0.0.2 | Default gateway |
| nameserver | 8.8.8.8 | DNS server |
| hamode | 0 | High availability mode |
| snat | yes | Source NAT |
| multigw | no | Multi-gateway |
| onlydefaultroutes | no | Only use default routes |
| routefilter | no | Route filter |
| IPV6forwarding | yes | IPv6 forwarding |
| dhcpv6 | no | DHCPv6 |

## WUI / API Access
| Parameter | Current Value | Description |
|-----------|--------------|-------------|
| enableapi | yes | Enable REST API |
| apiport | 443 | API port |
| wuiaccess | yes | Enable WUI |
| wuiport | 443 | WUI port |
| wuiiface | 0 | WUI interface |
| wuiservercertval | no | WUI server cert validation |
| wuicertmapping | 0 | WUI cert mapping |
| wuinestedgroups | no | WUI nested groups |
| WUITLSProtocols | 0 | WUI TLS protocol mask |
| multihomedwui | no | Multi-homed WUI |
| adminclientaccess | 0 | Admin client access |
| extendedperms | no | Extended permissions |

## SSH
| Parameter | Current Value | Description |
|-----------|--------------|-------------|
| sshaccess | yes | Enable SSH |
| sshport | 22 | SSH port |
| sshiface | all | SSH interface |
| geosshport | 22 | GEO SSH port |

## NTP
| Parameter | Current Value | Description |
|-----------|--------------|-------------|
| ntphost | pool.ntp.org | NTP server hostname or IP |
| ntpkeyid | 0 | NTPv3 key ID (1–99) |
| ntpkeysecret | ******** | NTPv3 shared secret |

## Syslog
| Parameter | Current Value | Description |
|-----------|--------------|-------------|
| SyslogPort | 514 | Syslog server port |
| SyslogProt | udp | Syslog protocol (udp/tcp) |
| SyslogCert | no | Syslog TLS certificate |
| CEFmsgFormat | no | CEF message format |

## Email / SMTP
| Parameter | Current Value | Description |
|-----------|--------------|-------------|
| emailenable | no | Enable email alerts |
| emailport | 25 | SMTP port |
| emailpassword | ******** | SMTP password |
| emailsslmode | 0 | SMTP SSL/TLS mode |

## SNMP
| Parameter | Current Value | Description |
|-----------|--------------|-------------|
| snmpenable | no | Enable SNMP |
| snmpV3enable | no | Enable SNMPv3 |
| snmptrapenable | no | Enable SNMP traps |
| snmpHaTrap | no | HA trap |

## RADIUS
| Parameter | Current Value | Description |
|-----------|--------------|-------------|
| radiusport | 0 | RADIUS port |
| radiussecret | ******** | RADIUS shared secret |
| radiusbackupport | 0 | Backup RADIUS port |
| radiusbackupsecret | ******** | Backup RADIUS secret |
| radiusrevalidateinterval | 60 | Revalidation interval (sec) |
| radiussendnasid | no | Send NAS ID |
| radiussendvendorspec | no | Send vendor-specific attributes |

## SSL / TLS
| Parameter | Current Value | Description |
|-----------|--------------|-------------|
| dhkeysize | 2048 | DH key size |
| ECCerts | 0 | ECC certificates |
| SSLStapling | no | OCSP stapling |
| SSLRefreshInterval | 3600 | SSL refresh interval |
| SSLDisableMasterSecret | no | Disable SSL master secret |
| SSLForceServerVerify | no | Force server verification |
| SSLOldLibraryVersion | no | Use old SSL library |
| sslrenegotiate | no | Allow SSL renegotiation |
| sslclienterrors | 0 | SSL client error threshold |
| KcdCipherSha1 | no | KCD SHA1 cipher |
| OCSPcertChecking | no | OCSP certificate checking |

## Backup
| Parameter | Current Value | Description |
|-----------|--------------|-------------|
| backupenable | no | Enable scheduled backup |
| backupmethod | wput | Backup method |
| backupday | 0 | Backup day |
| backuphour | 0 | Backup hour |
| backupminute | 0 | Backup minute |
| backuptop | no | Backup retention |
| backupsecure | yes | Secure backup transfer |
| backupnetstat | yes | Include netstat in backup |
| backuppassword | ******** | Backup server password |
| backupident | ******** | Backup server identity |

## Rate Limiting
| Parameter | Current Value | Description |
|-----------|--------------|-------------|
| MaxConnsLimit | 0 | Global max connections |
| MaxCPSLimit | 0 | Global max connections/sec |
| MaxRPSLimit | 0 | Global max requests/sec |
| MaxBandwidthLimit | 0 | Global max bandwidth |
| ClientMaxConnsLimit | 0 | Per-client max connections |
| ClientCPSLimit | 0 | Per-client connections/sec |
| ClientRPSLimit | 0 | Per-client requests/sec |
| ClientMaxBandwidthLimit | 0 | Per-client max bandwidth |
| ClientRepeatDelay | 60 | Client repeat delay (sec) |
| L7LimitInput | 0 | L7 input limit |
| SendRateLimitError | 0 | Send rate limit error |
| RateLimitFail | no | Rate limit fail action |
| LimitLogging | no | Limit logging |

## Session / Authentication
| Parameter | Current Value | Description |
|-----------|--------------|-------------|
| sessionauthmode | 0 | Session auth mode |
| sessioncontrol | yes | Session control |
| sessionidletime | 0 | Session idle timeout |
| sessionmaxfailattempts | 0 | Max failed auth attempts |
| sessionbasicauth | no | Allow basic auth |
| sessionlocalauth | no | Local auth |
| sessionconcurrent | 0 | Concurrent sessions |
| authtimeout | 30 | Auth timeout (sec) |
| authpostwait | 2000 | Auth post wait (ms) |
| clienttokentimeout | 120 | Client token timeout (sec) |
| dnssecclient | no | DNSSEC client |

## L4 / L7 Tuning
| Parameter | Current Value | Description |
|-----------|--------------|-------------|
| conntimeout | 660 | Connection timeout (sec) |
| finalpersist | 300 | Final persist (sec) |
| slowstart | 0 | Slow start |
| paranoia | 1 | Paranoia level |
| cachesize | 100 | Cache size |
| expect100 | 2 | Expect 100-continue |
| keepalive | yes | HTTP keepalive |
| rfcconform | yes | RFC conformance |
| addforwardheader | 1 | Add X-Forwarded-For header |
| addvia | no | Add Via header |
| transparent | no | Transparent mode |
| localbind | no | Local bind |
| nonlocalrs | yes | Non-local real servers |
| subnetoriginating | no | Subnet originating |
| rsarelocal | no | RSA relocal |
| L4SyncThreshold | 3 | L4 sync threshold |
| L4SyncPeriod | 50 | L4 sync period |
| L4SyncRefreshPeriod | 0 | L4 sync refresh period |
| L7NTLMProxy | yes | L7 NTLM proxy |
| tcptimestamp | no | TCP timestamps |
| tcpsack | no | TCP SACK |
| TCPnorecycle | no | TCP no recycle |
| resetclose | no | Reset on close |
| closeonerror | no | Close on error |
| droponfail | no | Drop on fail |
| dropatdrainend | no | Drop at drain end |

## DNS
| Parameter | Current Value | Description |
|-----------|--------------|-------------|
| DNSNamesEnable | yes | Enable DNS names |
| DNSUpdateInterval | 60 | DNS update interval (sec) |
| DNSReloadOnError | no | Reload DNS on error |
| directoryurl | https://acme-v02.api.letsencrypt.org/directory | Let's Encrypt directory URL |
| renewperiod | 30 | Certificate renew period (days) |
