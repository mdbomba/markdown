#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../_common.sh
source "${SCRIPT_DIR}/../_common.sh"

scenario="${1:-success}"

ensure_tools
load_license_params

new_pass="${NEW_API_PASS_OVERRIDE:-${New_Api_Pass:-}}"
if [[ -z "$new_pass" ]]; then
  echo "New_Api_Pass is required for password reset. Set NEW_API_PASS_OVERRIDE or New_Api_Pass." >&2
  exit 1
fi

encoded_new_pass="$(urlencode "$new_pass")"
query="passwd=${encoded_new_pass}"
run_endpoint_call "access/set_initial_passwd" "$scenario" "$query"
