#!/usr/bin/env bash
# Apply a SPLA (Service Provider License Agreement) license online.
# Only available on SPLA-variant LoadMaster firmware builds.
# Usage: ./access-spalicense.sh
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../_common.sh
source "${SCRIPT_DIR}/../_common.sh"

ensure_tools
load_license_params

prompt_if_empty Progress_User "Progress/KEMP account email"
prompt_if_empty Progress_Pass "Progress/KEMP account password" yes

echo ""
begin_step "Applying SPLA license"

encoded_name="$(urlencode "$Progress_User")"
encoded_pass="$(urlencode "$Progress_Pass")"
query="name=${encoded_name}&passwd=${encoded_pass}"
[[ -n "$Order_Id" ]] && query="${query}&orderid=${Order_Id}"

run_endpoint_call "access/spla_license" "apply" "$query" >/dev/null 2>&1

if [[ "$LAST_CODE" != "ok" ]]; then
  end_step_fail "${LAST_ERROR:-code=${LAST_CODE}}"
fi

end_step_ok
echo ""
echo "  SPLA license applied successfully."
echo "  Capture saved to: ${LAST_RAW_FILE}"
