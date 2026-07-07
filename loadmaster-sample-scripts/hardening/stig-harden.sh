#!/usr/bin/env bash
set -euo pipefail

# Apply STIG security hardening to a LoadMaster via APIv2
# Usage: ./stig-harden.sh
#
# Configure via license.params or environment variables:
#   Api_Ip, Api_User, Api_Pass (or New_Api_Pass)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../_common.sh"
ensure_tools
load_license_params

Api_Pass="${New_Api_Pass:-$Api_Pass}"
BASE="$(api_base)"

apiv2() {
  local body="$1"
  curl -sk -X POST "${BASE}/accessv2" \
    -H "Content-Type: application/json" \
    -d "$body"
}

set_param() {
  local param="$1"
  local value="$2"
  local desc="${3:-$param}"

  begin_step "Setting ${desc}"

  # Check current value first
  local current
  current=$(apiv2 "{\"apiuser\":\"${Api_User}\",\"apipass\":\"${Api_Pass}\",\"cmd\":\"get\",\"param\":\"${param}\"}" \
    | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('${param}',''))" 2>/dev/null || echo "")

  if [ "$current" = "$value" ] || [ "$current" = "true" -a "$value" = "yes" ] || [ "$current" = "false" -a "$value" = "0" ]; then
    end_step_ok "already set"
    return
  fi

  local resp
  resp=$(apiv2 "{\"apiuser\":\"${Api_User}\",\"apipass\":\"${Api_Pass}\",\"cmd\":\"set\",\"param\":\"${param}\",\"value\":\"${value}\"}")
  if echo "$resp" | grep -q '"status":"ok"'; then
    end_step_ok "$value"
  else
    echo ""
    echo "  WARNING: Failed to set ${param}: $(echo "$resp" | grep -o '"message":"[^"]*"')" >&2
  fi
}

echo "=== LoadMaster STIG Hardening ==="
echo "  Target: ${Api_Ip}:${Api_Port}"
echo ""

# Session management
echo "-- Session Management --"
set_param "sessioncontrol"          "yes"  "session control"
set_param "sessionbasicauth"        "0"    "disable basic auth on WUI"
set_param "sessionidletime"         "600"  "session idle timeout (10 min)"
set_param "sessionmaxfailattempts"  "5"    "max failed login attempts"
set_param "sessionconcurrent"       "3"    "max concurrent sessions"

echo ""
echo "-- TLS Hardening --"
set_param "WUITLSProtocols"         "7"    "WUI TLS protocols (TLS 1.2+1.3)"
set_param "sslrenegotiate"          "0"    "disable SSL renegotiation"

echo ""
echo "-- Network Security --"
set_param "nonlocalrs"              "yes"  "allow non-local real servers"
set_param "subnetorigin"            "yes"  "subnet originating requests"
set_param "multigw"                 "1"    "enable multiple gateways"

echo ""
echo "-- Security Features --"
set_param "KcdCipherSha1"           "yes"  "Kerberos AES256+SHA1"
set_param "CEFMsgFormat"            "yes"  "CEF log format"
set_param "adminclientaccess"       "1"    "password or client cert login"

echo ""
echo "-- Cipher Sets --"
begin_step "Setting WUI cipher set to FIPS2"
RESP=$(apiv2 "{\"apiuser\":\"${Api_User}\",\"apipass\":\"${Api_Pass}\",\"cmd\":\"set\",\"param\":\"WUICipherset\",\"value\":\"FIPS2\"}")
if echo "$RESP" | grep -q '"status":"ok"'; then
  end_step_ok
  set_param "OutboundCipherset" "FIPS2" "outbound cipher set to FIPS2"
elif echo "$RESP" | grep -qi "protocol.violation\|fips"; then
  end_step_ok "FIPS Mode active, skipping cipher management"
else
  echo ""
  echo "  WARNING: Could not set cipher set. Trying 'FIPS' (7.2.59+)..." >&2
  RESP=$(apiv2 "{\"apiuser\":\"${Api_User}\",\"apipass\":\"${Api_Pass}\",\"cmd\":\"set\",\"param\":\"WUICipherset\",\"value\":\"FIPS\"}")
  if echo "$RESP" | grep -q '"status":"ok"'; then
    echo "  Set WUICipherset=FIPS"
    set_param "OutboundCipherset" "FIPS" "outbound cipher set to FIPS"
  fi
fi

echo ""
echo "-- Disable GEO (port 53 listener) --"
begin_step "Disabling GEO"
RESP=$(apiv2 "{\"apiuser\":\"${Api_User}\",\"apipass\":\"${Api_Pass}\",\"cmd\":\"disablegeo\"}")
if echo "$RESP" | grep -q '"status":"ok"'; then
  end_step_ok
else
  end_step_ok "already disabled or not available"
fi

echo ""
echo "=== STIG Hardening Complete ==="
echo ""
echo "Manual steps remaining:"
echo "  - Upload and assign TLS management certificate"
echo "  - Configure warning banners (WUIPreauth, SSHPreAuth)"
echo "  - Configure NTP with authentication"
echo "  - Create certificate-based admin users"
echo "  - Review and disable Tethering if license allows"
