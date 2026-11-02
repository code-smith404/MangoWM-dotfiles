#!/usr/bin/env bash
render_theme(){
  local theme="$1" dst="$2"
  local pal="themes/$theme/palette.conf"
  declare -A P
  while IFS='=' read -r k v; do
    [[ -z "$k" || "$k" =~ ^# ]] && continue
    P["$k"]="$v"
  done < "$pal"
  rm -rf "$dst"; mkdir -p "$dst"
  cp -r templates/. "$dst"/
  for f in $(find "$dst" -type f); do
    for k in "${!P[@]}"; do
      perl -i -pe "s/\\{\\{${k}\\}\\}/${P[$k]}/g" "$f"
    done
  done
}
