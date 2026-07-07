#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../_common.sh
source "${SCRIPT_DIR}/../_common.sh"

scenario="${1:-success}"

ensure_tools
load_license_params

Api_Pass="${New_Api_Pass:-$Api_Pass}"

hostname_val="${hostname:-}"
prompt_if_empty hostname_val "Hostname"

run_endpoint_call "access/set" "$scenario" "param=hostname&value=${hostname_val}" >/dev/null 2>&1
echo "hostname=${hostname_val}"
