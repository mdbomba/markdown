#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../_common.sh
source "${SCRIPT_DIR}/../_common.sh"

scenario="${1:-success}"

ensure_tools
load_license_params

Api_Pass="${New_Api_Pass:-$Api_Pass}"

run_endpoint_call "access/getall" "$scenario" ""

if [[ "$LAST_CODE" == "ok" ]]; then
  xmllint --format "$LAST_RAW_FILE"
fi
