#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../_common.sh
source "${SCRIPT_DIR}/../_common.sh"

scenario="${1:-success}"

ensure_tools
load_license_params

run_endpoint_call "access/readeula" "$scenario" ""

if [[ -n "$LAST_MAGIC" ]]; then
  echo "MAGIC=${LAST_MAGIC}"
fi
