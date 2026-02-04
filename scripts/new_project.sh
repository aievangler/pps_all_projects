#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <project_slug>"
  echo "Slug must be lowercase letters, numbers, hyphen, underscore."
  exit 1
fi

slug="$1"

if [[ ! "$slug" =~ ^[a-z0-9_-]+$ ]]; then
  echo "Invalid slug: $slug"
  echo "Use lowercase letters, numbers, hyphen, underscore only."
  exit 1
fi

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || true)"
if [ -z "$repo_root" ]; then
  echo "Not in a Git repo. Run git init or switch to the repo first."
  exit 1
fi

template="$repo_root/projects/.template"
if [ ! -d "$template" ]; then
  echo "Template not found at $template"
  exit 1
fi

dest="$repo_root/projects/$slug"
if [ -e "$dest" ]; then
  echo "Project already exists: $dest"
  exit 1
fi

cp -R "$template" "$dest"

echo "Created project: $dest"
