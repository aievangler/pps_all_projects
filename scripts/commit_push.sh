#!/usr/bin/env bash
set -euo pipefail

msg="${1:-Update PPS project state}"

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || true)"
if [ -z "$repo_root" ]; then
  echo "Not in a Git repo. Run git init or switch to the repo first."
  exit 1
fi

cd "$repo_root"

git add -A
if git diff --cached --quiet; then
  echo "No changes to commit."
  exit 0
fi

git commit -m "$msg"

# Push may fail if offline; surface error to user.
git push
