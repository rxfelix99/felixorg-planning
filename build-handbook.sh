#!/usr/bin/env bash
set -euo pipefail

# build_felixorg_handbook_skeleton.sh
#
# Creates the recommended repo structure under:
#   git/felixorg-handbook
#
# Usage:
#   bash build_felixorg_handbook_skeleton.sh
#   bash build_felixorg_handbook_skeleton.sh --force   # overwrite seeded starter files
#
# Notes:
# - The script will create directories if missing.
# - It will only create starter files if they don't exist, unless --force is used.

FORCE=0
if [[ "${1:-}" == "--force" ]]; then
  FORCE=1
fi

ROOT="git/felixorg-handbook"

mkdir -p "$ROOT"

# Directory layout
mkdir -p \
  "$ROOT/handbook/10-architecture" \
  "$ROOT/handbook/20-storage" \
  "$ROOT/handbook/30-operations" \
  "$ROOT/assets/spreadsheets" \
  "$ROOT/assets/diagrams" \
  "$ROOT/build" \
  "$ROOT/dist"

# Helper: write file if absent (or --force)
write_file() {
  local path="$1"
  local content="$2"

  if [[ -f "$path" && $FORCE -eq 0 ]]; then
    echo "SKIP (exists): $path"
    return 0
  fi

  # Ensure parent dir exists
  mkdir -p "$(dirname "$path")"

  printf "%s" "$content" > "$path"
  echo "WRITE: $path"
}

# Root README
write_file "$ROOT/README.md" \
"# felixorg-handbook

Source-of-truth handbook content lives in \`handbook/\` and \`assets/\`.
Generated outputs (PDF, single-file markdown, etc.) go in \`dist/\` and are not hand-edited.

## Quick start

- Edit:
  - Markdown sections: \`handbook/**.md\`
  - Spreadsheet sources: \`assets/spreadsheets/**.xlsx\`
  - Diagram sources: \`assets/diagrams/**.vsdx\`

- Build order is defined in: \`build/chapters.txt\`
- Build metadata is in: \`build/metadata.yaml\`

## Conventions

- \`dist/\` is output only.
- Keep exported/derived assets alongside sources when helpful:
  - XLSX → CSV for diffs
  - VSDX → PDF/SVG for viewing and future-proofing
"

# Chapters list (explicit ordering)
write_file "$ROOT/build/chapters.txt" \
"handbook/10-architecture/overview.md
handbook/10-architecture/hosts.md
handbook/10-architecture/network.md
handbook/20-storage/principles.md
handbook/20-storage/mappings.md
handbook/30-operations/backup.md
handbook/30-operations/monitoring.md
"

# Pandoc metadata (optional but useful later)
write_file "$ROOT/build/metadata.yaml" \
"---
title: \"FelixOrg Handbook\"
author: \"FZ\"
date: \"\"
lang: \"en-US\"
toc: true
toc-depth: 3
numbersections: true
--- 
"

# Starter Markdown sections (minimal scaffolds)
write_file "$ROOT/handbook/10-architecture/overview.md" \
"# Architecture Overview

## Purpose

## High-level topology

## Naming conventions

## Key principles
"

write_file "$ROOT/handbook/10-architecture/hosts.md" \
"# Hosts

## Inventory

## Roles

## Notes
"

write_file "$ROOT/handbook/10-architecture/network.md" \
"# Network

## Subnets and addressing

## DNS / hosts conventions

## Remote access (Mesh/VPN)

## Diagram references
- Source: \`assets/diagrams/network_topology.vsdx\`
- Exports: \`assets/diagrams/network_topology.pdf\`, \`assets/diagrams/network_topology.svg\`
"

write_file "$ROOT/handbook/20-storage/principles.md" \
"# Storage Principles

## Goals

## Tiering strategy

## Backup model

## Tooling notes (DEVONthink / Calibre / etc.)
"

write_file "$ROOT/handbook/20-storage/mappings.md" \
"# Storage Mappings

## Authoritative inventory
- \`assets/spreadsheets/network_assets.xlsx\`
- Diff/export: \`assets/spreadsheets/network_assets.csv\`

## Notes
"

write_file "$ROOT/handbook/30-operations/backup.md" \
"# Backups

## Current approach

## Known bottlenecks

## Runbooks
"

write_file "$ROOT/handbook/30-operations/monitoring.md" \
"# Monitoring

## What matters

## Where logs live

## Alerts / thresholds
"

# Asset placeholders (empty files where it helps)
# We won't create fake XLSX/VSDX content; just add a placeholder note.
write_file "$ROOT/assets/spreadsheets/README.md" \
"# Spreadsheets

- Canonical editing format: **.xlsx**
- Keep a **.csv** export for git diffs when practical.
"

write_file "$ROOT/assets/diagrams/README.md" \
"# Diagrams

- Canonical editing format: **.vsdx**
- Export **.pdf** for viewing and archiving.
- Export **.svg** when practical for longevity and (limited) diffability.
"

# Keep dist empty but present in repo; you may later choose to .gitignore it.
write_file "$ROOT/dist/.gitkeep" ""

echo
echo "Done. Created handbook skeleton under: $ROOT"
echo "Tip: run from repo parent directory so 'git/felixorg-handbook' resolves correctly."
