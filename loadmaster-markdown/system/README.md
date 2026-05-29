# System commands

This directory documents the `23` LoadMaster REST primitives grouped under the **system** category.

| Command | Description |
|---------|-------------|
| [`access/get`](access-get.md) | Retrieves the current value of a single LoadMaster runtime parameter by name |
| [`access/set`](access-set.md) | Updates a single LoadMaster runtime parameter to a supplied value |
| [`access/getall`](access-getall.md) | Returns the current values for LoadMaster runtime parameters in a single XML response |
| [`access/reboot`](access-reboot.md) | Handles reboot |
| [`access/shutdown`](access-shutdown.md) | Handles shutdown |
| [`access/backup`](access-backup.md) | Downloads a LoadMaster configuration backup bundle from the appliance |
| [`access/restore`](access-restore.md) | Restores a previously exported LoadMaster configuration backup to the appliance |
| [`access/updatedetect`](access-updatedetect.md) | Checks whether newer software updates or patches are available for the appliance |
| [`access/setmotd`](access-setmotd.md) | Sets the message-of-the-day banner shown by the appliance |
| [`access/notice`](access-notice.md) | Retrieves or acknowledges appliance notices exposed through the REST API |
| [`access/factoryreset`](access-factoryreset.md) | Resets the appliance back to factory defaults |
| [`access/installpatch`](access-installpatch.md) | Uploads and installs a software patch package on the appliance |
| [`access/restorepatch`](access-restorepatch.md) | Reverts the appliance to the previously installed patch level when available |
| [`access/getpreviousversion`](access-getpreviousversion.md) | Returns information about the previously installed software version |
| [`access/enablexroot`](access-enablexroot.md) | Enables shell-level xroot access for support or recovery workflows |
| [`access/logging`](access-logging.md) | Retrieves logging statistics or downloads logging-related diagnostic artifacts, depending on the request parameters |
| [`access/stats`](access-stats.md) | Returns current appliance traffic and usage statistics |
| [`access/vstotals`](access-vstotals.md) | Returns aggregate totals across configured virtual services |
| [`access/setadminaccess`](access-setadminaccess.md) | Controls which source addresses are permitted to reach the administrative interface |
| [`access/listapi`](access-listapi.md) | Lists the REST primitives currently exposed by the appliance firmware build |
| [`access/addaddon`](access-addaddon.md) | Installs lm addon |
| [`access/listaddon`](access-listaddon.md) | Retrieves lm add on |
| [`access/deladdon`](access-deladdon.md) | Removes lm addon |
