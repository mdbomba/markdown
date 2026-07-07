#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../_common.sh
source "${SCRIPT_DIR}/../_common.sh"

scenario="${1:-success}"

ensure_tools
load_license_params

Api_Pass="${New_Api_Pass:-$Api_Pass}"

run_endpoint_call "access/get" "$scenario" "param=ntphost" >/dev/null 2>&1

value="$(extract_xml_value "$LAST_RAW_FILE" 'string(//ntphost)')"
if [[ -z "$value" ]]; then
  echo "ntphost=(not set)"
else
  echo "ntphost=${value}"
fi
