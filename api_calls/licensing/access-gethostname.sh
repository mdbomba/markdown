#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../_common.sh
source "${SCRIPT_DIR}/../_common.sh"

scenario="${1:-success}"

ensure_tools
load_license_params

Api_Pass="${New_Api_Pass:-$Api_Pass}"

run_endpoint_call "access/get" "$scenario" "param=hostname" >/dev/null 2>&1

value="$(extract_xml_value "$LAST_RAW_FILE" 'string(//hostname)')"
if [[ -z "$value" ]]; then
  echo "hostname=(not set)"
else
  echo "hostname=${value}"
fi
