#!/usr/bin/env bash
set -euo pipefail

# Create a virtual service with two real servers
# Usage: ./create-vs-with-rs.sh
#
# Configure via license.params or environment variables:
#   Api_Ip, Api_User, Api_Pass (or New_Api_Pass)
#   VS_IP, VS_PORT, RS1_IP, RS1_PORT, RS2_IP, RS2_PORT

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../_common.sh"
ensure_tools
load_license_params

Api_Pass="${New_Api_Pass:-$Api_Pass}"

VS_IP="${VS_IP:-10.0.0.50}"
VS_PORT="${VS_PORT:-443}"
VS_PROT="${VS_PROT:-tcp}"
VS_NICK="${VS_NICK:-Web App}"
RS1_IP="${RS1_IP:-192.168.1.10}"
RS1_PORT="${RS1_PORT:-8443}"
RS2_IP="${RS2_IP:-192.168.1.11}"
RS2_PORT="${RS2_PORT:-8443}"

BASE="$(api_base)"

apiv2() {
  local body="$1"
  curl -sk -X POST "${BASE}/accessv2" \
    -H "Content-Type: application/json" \
    -d "$body"
}

echo "=== Create Virtual Service ==="

begin_step "Creating VS ${VS_IP}:${VS_PORT}"
RESP=$(apiv2 "{\"apiuser\":\"${Api_User}\",\"apipass\":\"${Api_Pass}\",\"cmd\":\"addvs\",\"vs\":\"${VS_IP}\",\"port\":\"${VS_PORT}\",\"prot\":\"${VS_PROT}\",\"NickName\":\"${VS_NICK}\"}")
if echo "$RESP" | grep -q '"status":"ok"'; then
  end_step_ok
else
  end_step_fail "$(echo "$RESP" | grep -o '"message":"[^"]*"')"
fi

begin_step "Configuring VS (HTTPS, health checks)"
RESP=$(apiv2 "{\"apiuser\":\"${Api_User}\",\"apipass\":\"${Api_Pass}\",\"cmd\":\"modvs\",\"vs\":\"${VS_IP}\",\"port\":\"${VS_PORT}\",\"prot\":\"${VS_PROT}\",\"CheckType\":\"https\",\"CheckUrl\":\"/health\",\"Schedule\":\"wlc\"}")
if echo "$RESP" | grep -q '"status":"ok"'; then
  end_step_ok
else
  end_step_fail "$(echo "$RESP" | grep -o '"message":"[^"]*"')"
fi

begin_step "Adding RS1 ${RS1_IP}:${RS1_PORT}"
RESP=$(apiv2 "{\"apiuser\":\"${Api_User}\",\"apipass\":\"${Api_Pass}\",\"cmd\":\"addrs\",\"vs\":\"${VS_IP}\",\"port\":\"${VS_PORT}\",\"prot\":\"${VS_PROT}\",\"rs\":\"${RS1_IP}\",\"rsport\":\"${RS1_PORT}\"}")
if echo "$RESP" | grep -q '"status":"ok"'; then
  end_step_ok
else
  end_step_fail "$(echo "$RESP" | grep -o '"message":"[^"]*"')"
fi

begin_step "Adding RS2 ${RS2_IP}:${RS2_PORT}"
RESP=$(apiv2 "{\"apiuser\":\"${Api_User}\",\"apipass\":\"${Api_Pass}\",\"cmd\":\"addrs\",\"vs\":\"${VS_IP}\",\"port\":\"${VS_PORT}\",\"prot\":\"${VS_PROT}\",\"rs\":\"${RS2_IP}\",\"rsport\":\"${RS2_PORT}\"}")
if echo "$RESP" | grep -q '"status":"ok"'; then
  end_step_ok
else
  end_step_fail "$(echo "$RESP" | grep -o '"message":"[^"]*"')"
fi

begin_step "Verifying VS configuration"
RESP=$(apiv2 "{\"apiuser\":\"${Api_User}\",\"apipass\":\"${Api_Pass}\",\"cmd\":\"showvs\",\"vs\":\"${VS_IP}\",\"port\":\"${VS_PORT}\",\"prot\":\"${VS_PROT}\"}")
if echo "$RESP" | grep -q '"status":"ok"'; then
  end_step_ok
  echo ""
  echo "$RESP" | python3 -m json.tool 2>/dev/null || echo "$RESP"
else
  end_step_fail "$(echo "$RESP" | grep -o '"message":"[^"]*"')"
fi

echo ""
echo "=== Done ==="
