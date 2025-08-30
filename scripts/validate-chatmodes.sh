#!/usr/bin/env bash
set -euo pipefail
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "[validate] Checking chatmodes for front-matter and constraints"
errors=0

shopt -s nullglob
for f in memory-bank/chatmodes/*.chatmode.md; do
  [[ "$(basename "$f")" == "_TEMPLATE.chatmode.md" ]] && continue

  if ! grep -qE '^---$' "$f"; then
    echo "[validate] $f: missing front-matter start"; errors=$((errors+1))
  fi
  # Tools exact match check (order preserved), tolerant to quotes/spaces
  tools_line=$(grep -E '^tools:' "$f" | head -n1 | tr -d '[:space:]' | sed -E "s/[\"']//g")
  if [[ "$tools_line" != "tools:[codebase,editFiles,fetch]" ]]; then
    echo "[validate] $f: tools must be ['codebase', 'editFiles', 'fetch']"; errors=$((errors+1))
  fi
  if ! grep -qE "model: GPT-5 \(Preview\)|model: GPT-5 mini \(Preview\)" "$f"; then
    echo "[validate] $f: model must be GPT-5( Preview ) or GPT-5 mini (Preview)"; errors=$((errors+1))
  fi
  if grep -Eo '\[[^\]]+\]\((http|https)://[^)]+\)' "$f" >/dev/null; then
    echo "[validate] $f: external links are not allowed"; errors=$((errors+1))
  fi
  # One H1 line
  h1_count=$(grep -E '^# ' "$f" | wc -l | tr -d ' ')
  if [[ "$h1_count" != "1" ]]; then
    echo "[validate] $f: exactly one H1 required"; errors=$((errors+1))
  fi
done

if [[ $errors -eq 0 ]]; then
  echo "[validate] OK"
else
  echo "[validate] FAILED with $errors error(s)"; exit 1
fi
