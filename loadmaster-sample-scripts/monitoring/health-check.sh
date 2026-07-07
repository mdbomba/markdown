#!/usr/bin/env bash
set -euo pipefail

# Monitor LoadMaster health: stats, VS status, and optional ping test
# Usage: ./health-check.sh [--ping RS_IP]
#
# Configure via license.params or environment variables:
#   Api_Ip, Api_User, Api_Pass (or New_Api_Pass)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../_common.sh"
ensure_tools
load_license_params

Api_Pass="${New_Api_Pass:-$Api_Pass}"
BASE="$(api_base)"
PING_TARGET="${1:-}"
PING_IP="${2:-}"

apiv2() {
  local body="$1"
  curl -sk -X POST "${BASE}/accessv2" \
    -H "Content-Type: application/json" \
    -d "$body"
}

echo "=== LoadMaster Health Check ==="
echo "  Target: ${Api_Ip}:${Api_Port}"
echo "  Time:   $(date -u +%Y-%m-%dT%H:%M:%SZ)"
echo ""

# System stats
echo "-- System Statistics --"
STATS=$(apiv2 "{\"apiuser\":\"${Api_User}\",\"apipass\":\"${Api_Pass}\",\"cmd\":\"stats\"}")
if echo "$STATS" | grep -q '"status":"ok"'; then
  echo "$STATS" | python3 -c "
import sys, json
d = json.load(sys.stdin)
for key in ['CPU', 'TotalMemory', 'FreeMemory', 'TPS', 'SSLRate']:
    if key in d:
        print(f'  {key}: {d[key]}')
" 2>/dev/null || echo "  (could not parse stats)"
else
  echo "  ERROR: Could not retrieve stats"
fi

echo ""

# VS/RS totals
echo "-- Virtual Service Totals --"
TOTALS=$(apiv2 "{\"apiuser\":\"${Api_User}\",\"apipass\":\"${Api_Pass}\",\"cmd\":\"vstotals\"}")
if echo "$TOTALS" | grep -q '"status":"ok"'; then
  echo "$TOTALS" | python3 -c "
import sys, json
d = json.load(sys.stdin)
for key in ['VScount', 'VSUp', 'VSDown', 'VSDisabled', 'RScount', 'RSUp', 'RSDown', 'RSDisabled']:
    if key in d:
        print(f'  {key}: {d[key]}')
" 2>/dev/null || echo "  (could not parse totals)"
else
  echo "  ERROR: Could not retrieve VS totals"
fi

echo ""

# List virtual services
echo "-- Virtual Services --"
VLIST=$(apiv2 "{\"apiuser\":\"${Api_User}\",\"apipass\":\"${Api_Pass}\",\"cmd\":\"listvs\"}")
if echo "$VLIST" | grep -q '"status":"ok"'; then
  echo "$VLIST" | python3 -c "
import sys, json
d = json.load(sys.stdin)
vs_list = d.get('VS', d.get('vs', []))
if isinstance(vs_list, dict):
    vs_list = [vs_list]
for vs in vs_list:
    name = vs.get('NickName', vs.get('VSAddress', '?'))
    addr = vs.get('VSAddress', '?')
    port = vs.get('VSPort', '?')
    status = vs.get('Status', '?')
    print(f'  {name} ({addr}:{port}) — {status}')
" 2>/dev/null || echo "  (could not parse VS list)"
else
  echo "  No virtual services configured"
fi

# Optional ping test
if [ "$PING_TARGET" = "--ping" ] && [ -n "$PING_IP" ]; then
  echo ""
  echo "-- Ping Test: ${PING_IP} --"
  PING=$(apiv2 "{\"apiuser\":\"${Api_User}\",\"apipass\":\"${Api_Pass}\",\"cmd\":\"logging.ping\",\"addr\":\"${PING_IP}\"}")
  if echo "$PING" | grep -q '"status":"ok"'; then
    echo "$PING" | python3 -c "
import sys, json
d = json.load(sys.stdin)
msg = d.get('message', d.get('Data', ''))
# Extract the summary line
lines = msg.replace('#', '\n').split('\n')
for line in lines:
    if 'packet loss' in line or 'rtt' in line:
        print(f'  {line.strip()}')
" 2>/dev/null || echo "  Ping completed"
  else
    echo "  Ping failed"
  fi
fi

echo ""
echo "=== Done ==="
