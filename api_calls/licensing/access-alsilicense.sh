#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../_common.sh
source "${SCRIPT_DIR}/../_common.sh"

scenario="${1:-out-of-sequence}"

ensure_tools
load_license_params

Progress_User="${Progress_User:-michael.bomba@marklogic.com}"

if [[ "$scenario" == "success" && -z "$Progress_Pass" ]]; then
  read -s -p "Enter PASSWORD for $Progress_User for licensing: " Progress_Pass
  echo
fi

query=""
case "$scenario" in
  success)
    if [[ -z "$Progress_User" || -z "$Progress_Pass" ]]; then
      echo "Progress_User and Progress_Pass are required for success scenario." >&2
      exit 1
    fi
    lic_type_id="${LIC_TYPE_ID:-${LIC_TYPE_ID_OVERRIDE:-}}"
    if [[ -z "$lic_type_id" ]]; then
      echo "LIC_TYPE_ID is required for success scenario. Run successful access-alsilicensetypes.sh first or set LIC_TYPE_ID_OVERRIDE." >&2
      exit 1
    fi
    encoded_pass="$(urlencode "$Progress_Pass")"
    query="kempid=${Progress_User}&password=${encoded_pass}&lic_type_id=${lic_type_id}"
    ;;
  missing-param)
    query="kempid=${Progress_User}"
    ;;
  out-of-sequence)
    query=""
    ;;
  *)
    query=""
    ;;
esac

run_endpoint_call "access/alsilicense" "$scenario" "$query" 60
