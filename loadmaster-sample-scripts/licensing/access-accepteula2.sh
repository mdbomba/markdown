#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../_common.sh
source "${SCRIPT_DIR}/../_common.sh"

scenario="${1:-out-of-sequence}"

ensure_tools
load_license_params

accept_value="${ACCEPT_VALUE:-yes}"
magic2="${MAGIC2:-}"

case "$scenario" in
  success)
    if [[ -z "$magic2" ]]; then
      echo "MAGIC2 token not set. Run access-accepteula.sh first or export MAGIC2." >&2
      exit 1
    fi
    ;;
  out-of-sequence)
    if [[ -z "$magic2" ]]; then
      magic2="invalid-magic2"
    fi
    ;;
  missing-param)
    run_endpoint_call "access/accepteula2" "$scenario" "accept=${accept_value}"
    exit 0
    ;;
  *)
    if [[ -z "$magic2" ]]; then
      magic2="invalid-magic2"
    fi
    ;;
esac

query="magic=${magic2}&accept=${accept_value}"
run_endpoint_call "access/accepteula2" "$scenario" "$query"
