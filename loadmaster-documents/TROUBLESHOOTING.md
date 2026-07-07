# Troubleshooting the LoadMaster API

Common problems and solutions when working with the LoadMaster REST API.

---

## 1. API Returns HTML Instead of XML/JSON

**Symptom**: You get an HTML login page instead of an API response.

**Cause**: You're hitting the WUI (Web User Interface) port without proper authentication headers, or the API is disabled.

**Solution**:
```bash
# Verify the API is enabled
curl -sk -u "bal:PASSWORD" "https://$LM_IP/access/get?param=enableapi"

# If disabled, enable it
curl -sk -u "bal:PASSWORD" "https://$LM_IP/access/set?param=enableapi&value=yes"
```

If the API port is different from the WUI port, check:
```bash
curl -sk -u "bal:PASSWORD" "https://$LM_IP/access/get?param=apiport"
curl -sk -u "bal:PASSWORD" "https://$LM_IP/access/get?param=wuiport"
```

---

## 2. 401 Unauthorized After Licensing

**Symptom**: All API calls return `401` after running `alsilicense`.

**Cause**: The API interface is automatically disabled after licensing completes.

**Solution**: Re-enable the API, then continue with APIv2:
```bash
# Use the new password set during licensing
curl -sk -u "bal:NEW_PASSWORD" "https://$LM_IP/access/set?param=enableapi&value=yes"
```

**Note**: There may be a 5-25 second delay after `set_initial_passwd` before the appliance accepts the new credentials. Use a retry loop:
```bash
for i in 1 2 3 4 5; do
  sleep 5
  curl -sk -u "bal:$NEW_PASS" "https://$LM_IP/access/set?param=enableapi&value=yes" && break
done
```

---

## 3. APIv1 Commands Silently Fail on Long Values

**Symptom**: A `set` command returns HTTP 000 (connection reset) or succeeds but the value isn't applied.

**Cause**: APIv1 uses query strings, which are limited to ~2000-4000 characters depending on the firmware version. Long values like HTML warning banners (`WUIPreauth` is ~1800 chars) exceed this limit.

**Solution**: Use APIv2 for any value longer than ~500 characters:
```bash
# This FAILS via APIv1 (URL too long):
curl -sk -u "bal:PASS" "https://$LM_IP/access/set?param=WUIPreauth&value=<very long HTML>"

# This WORKS via APIv2 (no size limit):
curl -sk -X POST "https://$LM_IP/accessv2" \
  -d '{"apiuser":"bal","apipass":"PASS","cmd":"set","param":"WUIPreauth","value":"<very long HTML>"}'
```

---

## 4. APIv1 vs APIv2 Boolean/Array Differences

**Symptom**: Your script works with one API version but breaks with the other because values look different.

**Cause**: APIv1 and APIv2 represent the same data differently:

| Parameter | APIv1 (XML) | APIv2 (JSON) |
|-----------|-------------|--------------|
| `sessioncontrol` | `yes` | `true` |
| `enableapi` | `yes` | `true` |
| `sslrenegotiate` | `no` | `false` or `""` |
| `nameserver` | `8.8.8.8,8.8.4.4` | `["8.8.8.8","8.8.4.4"]` |
| `adminclientaccess` | `1` (string) | `1` (number) |

**Solution**: When parsing APIv2 JSON responses:
```bash
# Use jq with fallback for empty/false values
VALUE=$(curl -sk -X POST "https://$LM_IP/accessv2" \
  -d '{"apiuser":"bal","apipass":"PASS","cmd":"get","param":"sessioncontrol"}' \
  | jq -r '.sessioncontrol // empty')

# For boolean checks
if [ "$VALUE" = "true" ] || [ "$VALUE" = "yes" ]; then
  echo "Enabled"
fi
```

---

## 5. "Couldn't create RS" When Adding a Real Server

**Symptom**: Adding a real server returns "Couldn't create RS" even though the VS exists.

**Cause**: The VS has Sub-VSs enabled (it's a "Master VS"). You cannot add real servers directly to a Master VS -- you must add them to a Sub-VS.

**Solution**:
```bash
# First, find the SubVS index by showing the VS
curl -sk -X POST "https://$LM_IP/accessv2" \
  -d '{"apiuser":"bal","apipass":"PASS","cmd":"showvs","vs":"10.0.0.50","port":"443","prot":"tcp"}'

# Then add the RS using the SubVS numeric index
curl -sk -X POST "https://$LM_IP/accessv2" \
  -d '{"apiuser":"bal","apipass":"PASS","cmd":"addrs","vs":"3","rs":"192.168.1.10","rsport":"8443"}'
```

**Note**: When targeting a Sub-VS, use the numeric `VSIndex` as the `vs` parameter, not the IP address.

---

## 6. Management IP Change Breaks Connectivity

**Symptom**: After running `modiface` to change the management interface IP, all subsequent API calls fail.

**Cause**: You changed the IP of the interface you're connecting through.

**Solution**: Update your target IP immediately after the `modiface` call:
```bash
OLD_IP="10.0.0.100"
NEW_IP="10.0.0.200"

# Change the IP
curl -sk -X POST "https://$OLD_IP/accessv2" \
  -d "{\"apiuser\":\"bal\",\"apipass\":\"PASS\",\"cmd\":\"modiface\",\"iface\":\"0\",\"addr\":\"$NEW_IP/24\"}"

# All subsequent calls must use the new IP
LM_IP="$NEW_IP"
curl -sk -X POST "https://$LM_IP/accessv2" \
  -d '{"apiuser":"bal","apipass":"PASS","cmd":"get","param":"hostname"}'
```

---

## 7. Template Names with Spaces

**Symptom**: Template operations fail when the template name contains spaces.

**Cause**: In APIv1, spaces in query string values must be URL-encoded.

**Solution**:
```bash
# APIv1 — URL-encode the name
curl -sk -u "bal:PASS" "https://$LM_IP/access/deltemplate?name=Exchange%202019"

# APIv2 — no encoding needed (JSON body)
curl -sk -X POST "https://$LM_IP/accessv2" \
  -d '{"apiuser":"bal","apipass":"PASS","cmd":"deltemplate","name":"Exchange 2019"}'
```

---

## 8. FIPS Mode Prevents Cipher Set Changes

**Symptom**: Setting `WUICipherset` to `FIPS` returns a "protocol violation" error.

**Cause**: The LoadMaster is running in Software FIPS Mode, which manages cipher constraints automatically.

**Detection**:
```bash
# This error indicates SW FIPS Mode is active
curl -sk -X POST "https://$LM_IP/accessv2" \
  -d '{"apiuser":"bal","apipass":"PASS","cmd":"set","param":"WUICipherset","value":"FIPS"}'
# Returns error → FIPS Mode is active, skip cipher management
```

**Solution**: Skip `WUICipherset`, `OutboundCipherset`, and `WUITLS13Ciphersets` configuration when FIPS Mode is detected. The appliance handles these automatically.

---

## 9. Connection Timeout on Initial Setup

**Symptom**: Cannot connect to the LoadMaster API on a fresh deployment.

**Checklist**:
1. Verify the LoadMaster has booted (wait 2-3 minutes after deployment)
2. Confirm you're using HTTPS (the API does not serve HTTP)
3. Use `-k` with curl to skip certificate verification (self-signed cert)
4. Check that port 443 is accessible (or the configured API port)
5. For cloud deployments, verify security group / NSG rules allow port 443 inbound

```bash
# Test basic connectivity
curl -sk --connect-timeout 5 "https://$LM_IP/"

# Should return HTML (the WUI login page) if reachable
```

---

## 10. Commands Work in WUI but Fail via API

**Symptom**: A configuration change works in the web interface but fails through the API.

**Common causes**:
- **Wrong parameter name**: The API parameter name may differ from the WUI label. Use `getall` to find the exact parameter name.
- **Case sensitivity**: Some commands are case-sensitive (e.g., `getCloudHaParams` not `getcloudhaparams`).
- **Missing dependent parameters**: Some settings require other parameters to be set first.

**Debug approach**:
```bash
# Dump all parameters and search for the setting
curl -sk -X POST "https://$LM_IP/accessv2" \
  -d '{"apiuser":"bal","apipass":"PASS","cmd":"getall"}' | jq . > /tmp/all_params.json

# Search for the parameter name
grep -i "keyword" /tmp/all_params.json

# Check the API command list
curl -sk -X POST "https://$LM_IP/accessv2" \
  -d '{"apiuser":"bal","apipass":"PASS","cmd":"listapi"}' | jq .
```
