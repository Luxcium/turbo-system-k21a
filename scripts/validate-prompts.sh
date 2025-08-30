#!/usr/bin/env bash
set -euo pipefail
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "[validate] Checking prompts for front-matter, path marker, and heading contract"
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
  # Path marker must match filename and be placed after front-matter
  stem_basename=$(basename "$f")
  expected_marker="<!-- memory-bank/prompts/${stem_basename} -->"
  if ! grep -Fxq "$expected_marker" "$f"; then
    echo "[validate] $f: missing or incorrect path marker comment: $expected_marker"; errors=$((errors+1))
  else
    # Verify one blank line after marker and then H1 title
    marker_line=$(grep -n -F "$expected_marker" "$f" | head -n1 | cut -d: -f1)
    next_line=$((marker_line+1))
    title_line=$((marker_line+2))
    line_next=$(sed -n "${next_line}p" "$f")
    line_title=$(sed -n "${title_line}p" "$f")
    if [[ -n "$line_next" ]]; then
      echo "[validate] $f: must have exactly one blank line after path marker"; errors=$((errors+1))
    fi
    if ! grep -qE '^# ' <<<"$line_title"; then
      echo "[validate] $f: H1 title must appear immediately after one blank line following the path marker"; errors=$((errors+1))
    fi
  fi

  # First H2 must be the Slash Command heading
  first_h2=$(grep -En '^## ' "$f" | head -n1 | cut -d: -f2- || true)
  if [[ -z "${first_h2:-}" ]]; then
    echo "[validate] $f: missing required '## Slash Command' heading"; errors=$((errors+1))
  else
    if ! grep -Eq '^## Slash Command: /[a-z0-9-]+ - .+' <<<"$first_h2"; then
      echo "[validate] $f: first H2 must be '## Slash Command: /<stem> - <label>'"; errors=$((errors+1))
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
