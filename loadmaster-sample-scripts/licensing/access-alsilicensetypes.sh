#!/usr/bin/env bash
# Query available license types for this appliance/order from the Progress portal.
# Usage: ./access-alsilicensetypes.sh
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../_common.sh
source "${SCRIPT_DIR}/../_common.sh"

ensure_tools
load_license_params

prompt_if_empty Progress_User "Progress/KEMP account email"
prompt_if_empty Progress_Pass "Progress/KEMP account password" yes

echo ""
begin_step "Fetching available license types"

encoded_pass="$(urlencode "$Progress_Pass")"
query="kempid=${Progress_User}&password=${encoded_pass}"
[[ -n "$Order_Id" ]] && query="${query}&orderid=${Order_Id}"

run_endpoint_call "access/alsilicensetypes" "query" "$query" >/dev/null 2>&1

if [[ "$LAST_CODE" != "ok" ]]; then
  end_step_fail "${LAST_ERROR:-code=${LAST_CODE}}"
fi

success_json="$(extract_xml_value "$LAST_RAW_FILE" 'string(//Success)')"
if [[ -z "$success_json" ]]; then
  end_step_fail "no license types returned"
fi

mapfile -t _choices < <(printf '%s' "$success_json" | jq -r '.categories[].licenseTypes[] | "\(.id)|\(.description)"')
end_step_ok "${#_choices[@]} type(s) available"

echo ""
echo "  Available license types:"
for i in "${!_choices[@]}"; do
  id="${_choices[$i]%%|*}"
  desc="${_choices[$i]#*|}"
  printf '    %d)  %-12s  %s\n' "$((i+1))" "$id" "$desc"
done
echo ""
echo "  Capture saved to: ${LAST_RAW_FILE}"
