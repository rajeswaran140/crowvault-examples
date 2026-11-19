#!/usr/bin/env bash
# Regenerate every example from its request.json through the CrowVault API.
#
#   CROWVAULT_API_KEY=... scripts/regenerate.sh
#
# Use a free-plan key: paid plans add AI augmentation to the output, which is
# not reproducible. Needs bash, curl, jq and awk.
set -euo pipefail

api_url="${CROWVAULT_API_URL:-https://api.crowvault.ai/v1/tools/call}"
: "${CROWVAULT_API_KEY:?Set CROWVAULT_API_KEY (a free-plan key)}"

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
layout="$root/scripts/layout.json"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

for req in "$root"/[0-9][0-9]-*/request.json; do
  dir="$(dirname "$req")"
  name="$(basename "$dir")"

  code="$(curl -sS -o "$tmp/resp.json" -w '%{http_code}' -X POST "$api_url" \
    -H "Authorization: Bearer $CROWVAULT_API_KEY" \
    -H 'Content-Type: application/json' \
    --data-binary @"$req")"
  if [[ "$code" != 2* ]]; then
    echo "$name: HTTP $code" >&2
    cat "$tmp/resp.json" >&2
    exit 1
  fi
  # Tool errors come back as HTTP 200 with success: false.
  if ! jq -e '.success == true' "$tmp/resp.json" > /dev/null; then
    echo "$name: $(jq -r '.error // "unexpected response"' "$tmp/resp.json")" >&2
    exit 1
  fi
  jq -r '.result' "$tmp/resp.json" > "$tmp/out.md"

  # Split the fenced code blocks: block N goes to the Nth file in layout.json.
  rm -f "$tmp"/block_*
  awk -v out="$tmp/block_" '
    /^```/ { if (inb) { inb = 0; close(f) } else { inb = 1; f = out n++; printf "" > f }; next }
    inb { print > f }
  ' "$tmp/out.md"

  i=0
  while IFS= read -r file; do
    if [[ "$file" != "null" ]]; then
      if [[ ! -f "$tmp/block_$i" ]]; then
        echo "$name: expected a code block #$i for $file" >&2
        exit 1
      fi
      mkdir -p "$(dirname "$dir/$file")"
      cp "$tmp/block_$i" "$dir/$file"
    fi
    i=$((i + 1))
  done < <(jq -r --arg d "$name" '.[$d][] | if . == null then "null" else . end' "$layout")

  echo "$name: ok"
done
