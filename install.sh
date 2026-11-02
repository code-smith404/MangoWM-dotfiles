#!/usr/bin/env bash
set -euo pipefail
source lib/common.sh
THEME=""
DRY=0
YES=0
for a in "$@"; do
  case "$a" in
    --list) ls themes; exit 0;;
    --help) echo "install.sh [--theme NAME] [--dry-run] [--yes]"; exit 0;;
    --dry-run) DRY=1;;
    --yes) YES=1;;
    --theme) shift; THEME="$1";;
  esac
done
if [[ -z "$THEME" ]]; then
  echo "Themes:"; ls themes; read -rp "Choose: " THEME
fi
[[ -d "themes/$THEME" ]] || die "unknown theme"
info "Installing $THEME (dry-run=$DRY)"
TMP=$(mktemp -d)
source lib/render.sh
render_theme "$THEME" "$TMP/out"
if grep -R '{{' "$TMP/out" >/dev/null 2>&1; then
  err "unresolved placeholders"; grep -R '{{' "$TMP/out"; exit 1
fi
info "rendered ok"
rm -rf "$TMP"
