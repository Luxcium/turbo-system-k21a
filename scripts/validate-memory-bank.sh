#!/usr/bin/env bash
set -euo pipefail
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "[validate] Checking memory-bank instructions front-matter and links"
errors=0

shopt -s nullglob
for f in memory-bank/instructions/*.instructions.md; do
  # Skip template itself
  [[ "$(basename "$f")" == "_TEMPLATE.instructions.md" ]] && continue

  if ! grep -qE '^---$' "$f"; then
    echo "[validate] Missing front-matter start in $f"; errors=$((errors+1))
  fi
  if ! awk 'f&&/description:/{print;exit} /^---/{f=1}' "$f" | grep -q 'description:'; then
    echo "[validate] Missing description in $f"; errors=$((errors+1))
  fi
  if grep -qE '^applyTo:' "$f"; then
    echo "[validate] Note: applyTo present in $f (immutable by policy)"
  fi
  if grep -Eo '\[[^\]]+\]\((http|https)://[^)]+\)' "$f" >/dev/null; then
    echo "[validate] External links found in $f"; errors=$((errors+1))
  fi
done

if [[ $errors -eq 0 ]]; then
  echo "[validate] OK"
else
  echo "[validate] FAILED with $errors error(s)"; exit 1
fi
