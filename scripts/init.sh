#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

timestamp() {
  date -u +"%Y-%m-%dT%H:%M:%SZ"
}

echo "[init] Starting Layer 1 init at $(timestamp)"

FOUNDATION_FILES=(
  ".editorconfig"
  ".gitattributes"
  ".gitignore"
  "LICENSE"
  "README.md"
  "VERSION"
)

MISSING=()
for f in "${FOUNDATION_FILES[@]}"; do
  if [[ ! -f "$f" ]]; then
    MISSING+=("$f")
  fi
done

if [[ ${#MISSING[@]} -gt 0 ]]; then
  echo "[init] Missing foundation files: ${MISSING[*]}" >&2
else
  echo "[init] All core foundation files present"
fi

# Ensure scripts are executable
if compgen -G "scripts/*.sh" > /dev/null; then
  chmod +x scripts/*.sh || true
fi

# Initialize git repo if absent
if [[ ! -d .git ]]; then
  echo "[init] No git repo detected. Initializing..."
  git init >/dev/null
  git add .
  if git diff --cached --quiet; then
    echo "[init] Nothing to commit"
  else
    git commit -m "Scientia est lux principium✨" >/dev/null || true
  fi
else
  echo "[init] Git repo already initialized"
fi

# Print project info
echo "[init] Project path: $ROOT_DIR"
if [[ -f VERSION ]]; then
  echo "[init] Version: $(cat VERSION)"
fi

echo "[init] Completed at $(timestamp)"
