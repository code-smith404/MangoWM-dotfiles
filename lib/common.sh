info(){ printf '\033[1;34m[info]\033[0m %s\n' "$*"; }
warn(){ printf '\033[1;33m[warn]\033[0m %s\n' "$*"; }
err(){ printf '\033[1;31m[err]\033[0m %s\n' "$*" >&2; }
die(){ err "$*"; exit 1; }
