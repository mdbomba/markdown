# LoadMaster Licensing Scripts

## Layout
- `_common.sh` — shared helpers (config, capture, display, prompting)
- `run_license.sh` — interactive production runner; walks through the full licensing workflow
- `licensing/*.sh` — one script per API endpoint; can be run standalone for testing

## Usage
From `/home/chef`:

```bash
./api_calls/run_license.sh
```

Credentials are read from `license.params` if it exists; any missing values are prompted interactively.

## Standalone endpoint scripts
Each script in `licensing/` accepts an optional scenario label:

```bash
./api_calls/licensing/access-readeula.sh success
./api_calls/licensing/access-accepteula.sh missing-param
```

Supported scenarios: `success`, `missing-param`, `invalid-value`, `out-of-sequence`, `auth-failed`

## Environment overrides
- `LICENSE_PARAMS_FILE` — parameter file path (default: `/home/chef/license.params`)
- `CAPTURE_ROOT` — where raw responses are saved (default: `/home/chef/captures`)
- `LICENSE_TYPE` — license model passed to `access/accepteula` (default: `freemax`)
- `MAGIC` / `MAGIC2` / `LIC_TYPE_ID` — token overrides for standalone scriptlet use

## Captured output
Every API call saves two files under `captures/licensing/`:
- `*.xml` — raw response body
- `*.info.txt` — request metadata with passwords masked

## Known timing delays
Certain commands take significantly longer than normal API calls. The runner handles
these automatically, but be aware when calling scriptlets standalone:

| Command / Step | Reason | Handling |
|---|---|---|
| `access/alsilicense` | Contacts Progress licensing servers externally | `max_time=60`, retries |
| `access/set_initial_passwd` | Appliance settling after post-license restart | 5 retries × 5s gap |
| `access/set?param=enableapi` | Same post-license restart window | 3 retries × 5s gap |
| Certificate operations | External CA calls / key generation | Use `max_time=60`, add retries |

The default `max_time` for all other calls is 30 seconds.

The PS module (`master-deployment.ps1`) notes online licensing checks "could take up to 5 minutes"
and uses `sleep 5` after appliance online detection plus `sleep 3` before/after several init calls.

## License source flows
| Source | EULA type | License command |
|--------|-----------|-----------------|
| `ONLINE` | `free`/`trial` | `alsilicense` (no orderid) |
| `ONLINE-SPLA` | `free`/`trial` | `alsilicense` (with orderid) or `spla_license` |
| `LOCAL-SPLA` | `free`/`trial` | `aslactivate` (`aslhost`, `aslport`) |
| `LOCAL-MELA` | `free`/`trial` | `aslactivate` (`aslhost`, `aslport`) |

## Kill / deactivate commands (from PS module source)
| REST Command | PS Cmdlet | Parameters | Notes |
|-------------|-----------|------------|-------|
| `access/kill_instance` | `Remove-Instance` | `name`, `passwd`, `kill=1` | Non-SPLA deactivation |
| `access/kill_spla_instance` | `Remove-SplaInstance` | `name`, `passwd`, `kill=1` | SPLA deactivation |
| `access/killaslinstance` | `Stop-AslInstance` | none | ASL deactivation |

All three kill commands return `Unknown command` on firmware `7.2.54.x` (LTSF train).
