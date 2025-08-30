#!/usr/bin/env bash
set -euo pipefail
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Slash Commands"
grep -Rho "^## Slash Command: /[a-z0-9-]+ - .*" memory-bank/prompts | sed 's/^## Slash Command: //'
