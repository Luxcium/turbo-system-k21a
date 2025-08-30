#!/usr/bin/env bash
set -euo pipefail
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "[validate] Checking prompts for front-matter and heading contract"
errors=0

shopt -s nullglob
for f in memory-bank/prompts/*.prompt.md; do
  [[ "$(basename "$f")" == "_TEMPLATE.prompt.md" ]] && continue

  if ! grep -qE '^---$' "$f"; then
    echo "[validate] $f: missing front-matter start"; errors=$((errors+1))
  fi
  if ! awk 'f&&/description:/{print;exit} /^---/{f=1}' "$f" | grep -q 'description:'; then
    echo "[validate] $f: missing description in front-matter"; errors=$((errors+1))
  fi
  # Heading contract: no H1, first header must be '## Slash Command: /... - ...'
  if grep -Eq '^# ' "$f"; then
    echo "[validate] $f: H1 headings are not allowed"; errors=$((errors+1))
  fi
  first_header=$(grep -En '^(##|###) ' "$f" | head -n1 | cut -d: -f2- || true)
  if [[ -z "${first_header:-}" ]]; then
    echo "[validate] $f: missing required '## Slash Command' heading"; errors=$((errors+1))
  else
    if ! grep -Eq '^## Slash Command: /[a-z0-9-]+ - .+' <<<"$first_header"; then
      echo "[validate] $f: first header must be '## Slash Command: /<stem> - <label>'"; errors=$((errors+1))
    fi
  fi
  # External links not allowed
  if grep -Eo '\[[^\]]+\]\((http|https)://[^)]+\)' "$f" >/dev/null; then
    echo "[validate] $f: external links are not allowed"; errors=$((errors+1))
  fi
done

if [[ $errors -eq 0 ]]; then
  echo "[validate] OK"
else
  echo "[validate] FAILED with $errors error(s)"; exit 1
fi
