#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

echo "[triad] Running 3A/3B/3C validators and summarizing context"

ok() { echo -e "\e[32m✔\e[0m $*"; }
err() { echo -e "\e[31m✘\e[0m $*"; }

errors=0

# Run validators if present
if [[ -x scripts/validate-memory-bank.sh ]]; then
  if scripts/validate-memory-bank.sh >/dev/null; then ok "3A instructions valid"; else err "3A instructions failed"; errors=$((errors+1)); fi
else
  err "3A validator missing (scripts/validate-memory-bank.sh)"; errors=$((errors+1))
fi

if [[ -x scripts/validate-chatmodes.sh ]]; then
  if scripts/validate-chatmodes.sh >/dev/null; then ok "3B chatmodes valid"; else err "3B chatmodes failed"; errors=$((errors+1)); fi
else
  err "3B validator missing (scripts/validate-chatmodes.sh)"; errors=$((errors+1))
fi

if [[ -x scripts/validate-prompts.sh ]]; then
  if scripts/validate-prompts.sh >/dev/null; then ok "3C prompts valid"; else err "3C prompts failed"; errors=$((errors+1)); fi
else
  err "3C validator missing (scripts/validate-prompts.sh)"; errors=$((errors+1))
fi

# Summarize files
echo
echo "[triad] Inventory"
shopt -s nullglob
inst=(memory-bank/instructions/*.instructions.md)
cm=(memory-bank/chatmodes/*.chatmode.md)
pr=(memory-bank/prompts/*.prompt.md)
echo "- Instructions:"
for f in "${inst[@]:-}"; do echo "  - $f"; done
echo "- Chatmodes:"
for f in "${cm[@]:-}"; do echo "  - $f"; done
echo "- Prompts:"
for f in "${pr[@]:-}"; do echo "  - $f"; done

# Check VS Code wiring
echo "\n[triad] VS Code wiring"
if [[ -f .vscode/settings.json ]]; then
  if grep -q 'memory-bank/instructions' .vscode/settings.json && \
     grep -q 'memory-bank/prompts' .vscode/settings.json && \
     grep -q 'memory-bank/chatmodes' .vscode/settings.json; then
     ok ".vscode/settings.json references triad locations"
  else
     err ".vscode/settings.json missing some triad references"; errors=$((errors+1))
  fi
else
  err ".vscode/settings.json missing"; errors=$((errors+1))
fi

if [[ $errors -eq 0 ]]; then
  ok "Triad health: OK"
  exit 0
else
  err "Triad health: FAILED with $errors issue(s)"
  exit 1
fi
