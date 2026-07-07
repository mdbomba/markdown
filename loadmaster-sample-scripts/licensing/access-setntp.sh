#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../_common.sh
source "${SCRIPT_DIR}/../_common.sh"

scenario="${1:-success}"

ensure_tools
load_license_params

Api_Pass="${New_Api_Pass:-$Api_Pass}"

ntp_host="${ntphost:-}"
prompt_if_empty ntp_host "NTP server hostname or IP"

run_endpoint_call "access/set" "$scenario" "param=ntphost&value=${ntp_host}"
