#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/code-smith404/MangoWM-dotfiles.git"
BRANCH="main"

# Bootstrap when run via curl (no local checkout)
SCRIPT_DIR="."
if [[ ! -f "${SCRIPT_DIR}/lib/common.sh" ]]; then
  TMPCLONE=$(mktemp -d)
  trap 'rm -rf "$TMPCLONE"' EXIT
  git clone --depth 1 --branch "$BRANCH" "$REPO_URL" "$TMPCLONE/repo" >/dev/null 2>&1
  "$TMPCLONE/repo/install.sh" "$@"
  exit $?
fi

source lib/common.sh
THEME=""
DRY=0
YES=0
while [[ $# -gt 0 ]]; do
  case "$1" in
    --list) ls themes; exit 0;;
    --help) echo "install.sh [--theme NAME] [--dry-run] [--yes]"; exit 0;;
    --dry-run) DRY=1; shift;;
    --yes) YES=1; shift;;
    --theme) shift; THEME="$1"; shift;;
    *) die "unknown arg $1";;
  esac
done
if [[ -z "$THEME" ]]; then
  echo "Themes:"; ls themes; read -rp "Choose: " THEME
fi
[[ -d "themes/$THEME" ]] || die "unknown theme $THEME"
info "Installing $THEME (dry-run=$DRY)"
TMP=$(mktemp -d)
source lib/render.sh
render_theme "$THEME" "$TMP/out"
if grep -R '{{' "$TMP/out" >/dev/null 2>&1; then
  err "unresolved placeholders"; grep -R '{{' "$TMP/out"; exit 1
fi
info "rendered ok"
rm -rf "$TMP"
