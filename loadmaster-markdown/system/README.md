# System

Core system management commands for LoadMaster configuration, maintenance, and monitoring. The `access/set` and `access/get` commands are the most commonly used — they read and write any of the 200+ runtime parameters.

## Commands (41)

### Parameters
| Command | Description |
|---------|-------------|
| [`access/get`](access-get.md) | Get a single parameter value |
| [`access/set`](access-set.md) | Set a single parameter value (see this file for APIv2 usage) |
| [`access/getall`](access-getall.md) | Get all parameters at once |
| [`access/listapi`](access-listapi.md) | List all available API commands |

### Maintenance
| Command | Description |
|---------|-------------|
| [`access/reboot`](access-reboot.md) | Reboot the appliance |
| [`access/shutdown`](access-shutdown.md) | Shutdown the appliance |
| [`access/backup`](access-backup.md) | Download configuration backup |
| [`access/restore`](access-restore.md) | Restore configuration from backup |
| [`access/factoryreset`](access-factoryreset.md) | Reset to factory defaults |

### Firmware & Add-ons
| Command | Description |
|---------|-------------|
| [`access/installpatch`](access-installpatch.md) | Install firmware patch |
| [`access/restorepatch`](access-restorepatch.md) | Rollback to previous patch |
| [`access/getpreviousversion`](access-getpreviousversion.md) | Get previous firmware version |
| [`access/updatedetect`](access-updatedetect.md) | Check for available updates |
| [`access/addaddon`](access-addaddon.md) | Install add-on package |
| [`access/listaddon`](access-listaddon.md) | List installed add-ons |
| [`access/deladdon`](access-deladdon.md) | Remove add-on |

### Monitoring & Access
| Command | Description |
|---------|-------------|
| [`access/stats`](access-stats.md) | Get traffic/usage statistics |
| [`access/vstotals`](access-vstotals.md) | Get aggregate VS totals |
| [`access/logging`](access-logging.md) | Retrieve log files and statistics |
| [`access/logging.listsyslogfiles`](access-logging.listsyslogfiles.md) | List system log files |
| [`access/logging.clearlogs`](access-logging.clearlogs.md) | Clear system log files |
| [`access/logging.savelogs`](access-logging.savelogs.md) | Save system log files |
| [`access/logging.listextlogfiles`](access-logging.listextlogfiles.md) | List extended log files |
| [`access/logging.clearextlogs`](access-logging.clearextlogs.md) | Clear extended log files |
| [`access/logging.saveextlogs`](access-logging.saveextlogs.md) | Save extended log files |
| [`access/logging.isextesplogenabled`](access-logging.isextesplogenabled.md) | Check if extended ESP logging is enabled |
| [`access/logging.enableextesplog`](access-logging.enableextesplog.md) | Enable extended ESP logging |
| [`access/logging.disableextesplog`](access-logging.disableextesplog.md) | Disable extended ESP logging |
| [`access/logging.ping`](access-logging.ping.md) | Perform a ping |
| [`access/logging.ping6`](access-logging.ping6.md) | Perform a ping (IPv6) |
| [`access/logging.traceroute`](access-logging.traceroute.md) | Perform a traceroute |
| [`access/logging.top`](access-logging.top.md) | Run a top command |
| [`access/logging.meminfo`](access-logging.meminfo.md) | Retrieve memory information |
| [`access/logging.resetstats`](access-logging.resetstats.md) | Reset statistics |
| [`access/logging.ssoflush`](access-logging.ssoflush.md) | Flush the SSO authentication cache |
| [`access/logging.savemlogcdata`](access-logging.savemlogcdata.md) | Save temporary WAF remote log data |
| [`access/logging.clearmlogcdata`](access-logging.clearmlogcdata.md) | Clear temporary WAF remote log data |
| [`access/notice`](access-notice.md) | Get/acknowledge system notices |
| [`access/setadminaccess`](access-setadminaccess.md) | Restrict admin interface access by source IP |
| [`access/setmotd`](access-setmotd.md) | Set message-of-the-day banner |
| [`access/enablexroot`](access-enablexroot.md) | Enable xroot shell access (support use) |
| [`access/showlocalreservedports`](access-showlocalreservedports.md) | Show reserved local ports (7.2.61+) |
| [`access/setlocalreservedports`](access-setlocalreservedports.md) | Set reserved local ports (7.2.61+) |

## Key Reference

The `access/set` document contains the comprehensive APIv1 vs APIv2 comparison, the full list of STIG hardening parameters, and the WUI warning banner workaround.
