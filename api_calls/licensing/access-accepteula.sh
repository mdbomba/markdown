#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../_common.sh
source "${SCRIPT_DIR}/../_common.sh"

scenario="${1:-invalid-value}"

ensure_tools
load_license_params

magic="${MAGIC:-}"
if [[ -z "$magic" ]]; then
  echo "MAGIC token not set. Run access-readeula.sh first or export MAGIC." >&2
  exit 1
fi

case "$scenario" in
  success)
    license_type="${LICENSE_TYPE:-}"
    if [[ -z "$license_type" ]]; then
      echo "Set LICENSE_TYPE for success scenario." >&2
      exit 1
    fi
    ;;
  invalid-value)
    license_type="${LICENSE_TYPE:-freemax}"
    ;;
  missing-param)
    run_endpoint_call "access/accepteula" "$scenario" ""
    exit 0
    ;;
  *)
    license_type="${LICENSE_TYPE:-freemax}"
    ;;
esac

query="magic=${magic}&type=${license_type}"
run_endpoint_call "access/accepteula" "$scenario" "$query"

if [[ -n "$LAST_MAGIC" ]]; then
  echo "MAGIC2=${LAST_MAGIC}"
fi
