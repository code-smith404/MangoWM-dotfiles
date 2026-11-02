#!/usr/bin/env bash
set -euo pipefail
source lib/common.sh
info "Removing installed mango configs"
rm -rf ~/.config/mango
info "done"
