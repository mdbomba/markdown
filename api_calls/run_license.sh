#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./_common.sh
source "${SCRIPT_DIR}/_common.sh"

ensure_tools

echo ""
echo "=== Kemp LoadMaster Licensing Wizard ==="
echo ""

# ── credentials ───────────────────────────────────────────────────────────────

load_license_params

prompt_if_empty Api_Ip       "Appliance IP address"
prompt_if_empty Api_Port     "Management port (default 443)"
prompt_if_empty Api_User     "API admin username"
prompt_if_empty Api_Pass     "API admin password" yes
prompt_if_empty New_Api_Pass "New password for admin account" yes
prompt_if_empty License_Type "License model (e.g. mela, melaenterprise)"
prompt_if_empty Progress_User "Progress (KEMP) account email"
prompt_if_empty Progress_Pass "Progress (KEMP) account password" yes
prompt_if_empty Order_Id     "Order ID (leave blank for trial)"
prompt_if_empty ntphost      "NTP server hostname or IP"
prompt_if_empty nameserver   "DNS nameserver(s) (comma-separated for multiple)"
prompt_if_empty hostname     "Appliance hostname"

echo ""
echo "  Appliance  : ${Api_Ip}:${Api_Port}"
echo "  API user   : ${Api_User}"
echo "  License    : ${License_Type}"
echo "  NTP        : ${ntphost}"
echo "  DNS        : ${nameserver}"
echo "  Hostname   : ${hostname}"
echo "  KEMP user  : ${Progress_User}"
echo "  Order ID   : ${Order_Id:-(trial)}"
echo ""

# ── step 1: check current license status ──────────────────────────────────────

begin_step "Checking license status"
_saved_pass="$Api_Pass"
Api_Pass="${New_Api_Pass}"
run_endpoint_call "access/get" "check" "param=version" >/dev/null 2>&1
Api_Pass="$_saved_pass"
if [[ "$LAST_CODE" == "ok" ]]; then
  end_step_ok "already licensed"
  echo ""
  echo "  Appliance is already licensed. Nothing to do."
  echo ""
  exit 0
fi
end_step_ok "not yet licensed"

# ── step 2: read EULA and get magic token ─────────────────────────────────────

begin_step "Reading EULA"
run_endpoint_call "access/readeula" "check" "" >/dev/null 2>&1
magic="$LAST_MAGIC"
if [[ -z "$magic" ]]; then
  end_step_fail "${LAST_ERROR:-no magic token returned}"
fi
end_step_ok "EULA token received"

# ── step 3: accept EULA (step 1) ──────────────────────────────────────────────

begin_step "Accepting EULA (step 1 of 2)"
run_endpoint_call "access/accepteula" "step1" "magic=${magic}&type=${License_Type}" >/dev/null 2>&1
magic2="$LAST_MAGIC"
if [[ -z "$magic2" ]]; then
  end_step_fail "${LAST_ERROR:-no second magic token}"
fi
end_step_ok

# ── step 4: accept EULA (step 2) ──────────────────────────────────────────────

begin_step "Accepting EULA (step 2 of 2)"
run_endpoint_call "access/accepteula2" "step2" "magic=${magic2}&accept=yes" >/dev/null 2>&1
if [[ "$LAST_CODE" != "ok" ]]; then
  end_step_fail "${LAST_ERROR:-code=${LAST_CODE}}"
fi
end_step_ok

# ── step 5: fetch available license types ─────────────────────────────────────

begin_step "Fetching available license types"
encoded_pass="$(urlencode "$Progress_Pass")"
query="kempid=${Progress_User}&password=${encoded_pass}"
[[ -n "$Order_Id" ]] && query="${query}&orderid=${Order_Id}"
run_endpoint_call "access/alsilicensetypes" "fetch" "$query" >/dev/null 2>&1
success_json="$(extract_xml_value "$LAST_RAW_FILE" 'string(//Success)')"
if [[ -z "$success_json" ]]; then
  end_step_fail "${LAST_ERROR:-no license types returned}"
fi
mapfile -t _choices < <(printf '%s' "$success_json" | jq -r '.categories[].licenseTypes[] | "\(.id)|\(.description)"')
end_step_ok "${#_choices[@]} type(s) available"

# ── interactive license selection ─────────────────────────────────────────────

echo ""
echo "  Available license types:"
for i in "${!_choices[@]}"; do
  desc="${_choices[$i]#*|}"
  printf '    %d) %s\n' "$((i+1))" "$desc"
done
echo ""
while true; do
  read -r -p "  Select license type [1-${#_choices[@]}]: " _sel
  if [[ "$_sel" =~ ^[0-9]+$ ]] && (( _sel >= 1 && _sel <= ${#_choices[@]} )); then
    lic_id="${_choices[$((_sel-1))]%%|*}"
    lic_desc="${_choices[$((_sel-1))]#*|}"
    echo "  → ${lic_desc}"
    echo ""
    break
  fi
  echo "  Invalid selection, please try again."
done

# ── step 6: install license ───────────────────────────────────────────────────

begin_step "Installing license"
query="kempid=${Progress_User}&password=${encoded_pass}&lic_type_id=${lic_id}"
run_endpoint_call "access/alsilicense" "install" "$query" 60 >/dev/null 2>&1
if [[ "$LAST_CODE" != "ok" ]]; then
  end_step_fail "${LAST_ERROR:-code=${LAST_CODE}}"
fi
end_step_ok

# ── step 7: reset admin password ──────────────────────────────────────────────

begin_step "Resetting admin password"
encoded_new_pass="$(urlencode "$New_Api_Pass")"
for _attempt in 1 2 3 4 5; do
  run_endpoint_call "access/set_initial_passwd" "reset" "passwd=${encoded_new_pass}" >/dev/null 2>&1
  [[ "$LAST_CODE" == "ok" ]] && break
  sleep 5
done
if [[ "$LAST_CODE" != "ok" ]]; then
  end_step_fail "${LAST_ERROR:-code=${LAST_CODE}}"
fi
end_step_ok
Api_Pass="${New_Api_Pass}"

sleep 10  # wait for appliance to complete post-licensing setup before re-enabling API

# ── step 8: re-enable API ─────────────────────────────────────────────────────

begin_step "Re-enabling API"
for _attempt in 1 2 3; do
  run_endpoint_call "access/set" "enableapi" "param=enableapi&value=yes" >/dev/null 2>&1
  [[ "$LAST_CODE" == "ok" ]] && break
  sleep 5
done
if [[ "$LAST_CODE" != "ok" ]]; then
  end_step_fail "${LAST_ERROR:-code=${LAST_CODE}}"
fi
end_step_ok

# ── step 9: set NTP server ────────────────────────────────────────────────────

begin_step "Setting NTP server"
for _attempt in 1 2 3; do
  run_endpoint_call "access/set" "ntp" "param=ntphost&value=${ntphost}" >/dev/null 2>&1
  [[ "$LAST_CODE" == "ok" ]] && break
  sleep 3
done
if [[ "$LAST_CODE" != "ok" ]]; then
  end_step_fail "${LAST_ERROR:-code=${LAST_CODE}}"
fi
end_step_ok "${ntphost}"

# ── step 10: set nameserver ───────────────────────────────────────────────────

begin_step "Setting DNS nameserver"
run_endpoint_call "access/set" "nameserver" "param=nameserver&value=${nameserver}" >/dev/null 2>&1
if [[ "$LAST_CODE" != "ok" ]]; then
  end_step_fail "${LAST_ERROR:-code=${LAST_CODE}}"
fi
end_step_ok "${nameserver}"

# ── step 11: set hostname ─────────────────────────────────────────────────────

begin_step "Setting hostname"
run_endpoint_call "access/set" "hostname" "param=hostname&value=${hostname}" >/dev/null 2>&1
if [[ "$LAST_CODE" != "ok" ]]; then
  end_step_fail "${LAST_ERROR:-code=${LAST_CODE}}"
fi
end_step_ok "${hostname}"

# ── done ──────────────────────────────────────────────────────────────────────

echo ""
echo "  ✓  License installed successfully."
echo "  ✓  Admin password has been reset."
echo "  ✓  NTP server set to ${ntphost}."
echo "  ✓  DNS nameserver set to ${nameserver}."
echo "  ✓  Hostname set to ${hostname}."
echo "  Captures saved to: ${CAPTURE_ROOT}/licensing/"
echo ""
