#!/usr/bin/env bash
set -euo pipefail
source lib/common.sh
source lib/render.sh
fail=0
for t in themes/*/; do
  name=$(basename "$t")
  tmp=$(mktemp -d)
  render_theme "$name" "$tmp/out"
  if grep -R '{{' "$tmp/out" >/dev/null 2>&1; then
    err "$name has unresolved placeholders"; grep -R '{{' "$tmp/out"; fail=1
  else
    info "$name OK"
  fi
  rm -rf "$tmp"
done
exit $fail
