#!/usr/bin/env bash
# get_ip.sh — print your public IP, with optional geo / ISP details.
#
#   get_ip            full details (IP, location, ISP, timezone, ...)
#   get_ip --ip       IP address only (quick / privacy-friendly)
#
# No API key required. Primary source: ipinfo.io (HTTPS).
# Falls back to ipify (IP only) if the detail source is unavailable.
set -euo pipefail

ip_only=0
[[ "${1:-}" == "--ip" || "${1:-}" == "-i" ]] && ip_only=1

# Pick a JSON parser: prefer jq, fall back to python3 (always on Ubuntu).
have_jq=0
command -v jq >/dev/null 2>&1 && have_jq=1

json="$(curl -sS --max-time 10 https://ipinfo.io/json 2>/dev/null || true)"

# get <key> -> value from $json (empty if missing)
get() {
  local key="$1"
  if (( have_jq )); then
    jq -r --arg k "$key" '.[$k] // empty' <<<"$json"
  else
    JSON="$json" python3 -c '
import os, sys, json
try:
    v = json.loads(os.environ["JSON"]).get(sys.argv[1])
    if v not in (None, ""):
        print(v)
except Exception:
    pass
' "$key"
  fi
  return 0
}

ip="$(get ip)"

# Fallback: IP only, if the detail source didn't give us one
if [[ -z "$ip" ]]; then
  ip="$(curl -sS --max-time 10 'https://api64.ipify.org?format=txt' || true)"
  [[ -n "$ip" ]] || { echo "error: could not determine IP" >&2; exit 1; }
  echo "$ip"
  exit 0
fi

if (( ip_only )); then
  echo "$ip"
  exit 0
fi

# show <label> <key> -> print "label  value" if the field is present
show() {
  local val
  val="$(get "$2")"
  [[ -n "$val" ]] && printf '%-12s %s\n' "$1" "$val"
  return 0
}

printf '%-12s %s\n' "IP:"        "$ip"
show "City:"      city
show "Region:"    region
show "Country:"   country
show "ISP/Org:"   org
show "Lat, Long:" loc
show "Timezone:"  timezone
