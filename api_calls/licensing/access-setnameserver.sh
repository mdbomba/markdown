#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../_common.sh
source "${SCRIPT_DIR}/../_common.sh"

scenario="${1:-success}"

ensure_tools
load_license_params

Api_Pass="${New_Api_Pass:-$Api_Pass}"

ns="${nameserver:-}"
prompt_if_empty ns "DNS nameserver(s) (comma-separated for multiple)"

run_endpoint_call "access/set" "$scenario" "param=nameserver&value=${ns}"
