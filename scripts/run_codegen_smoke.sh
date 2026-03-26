#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   scripts/run_codegen_smoke.sh [march]
# Default march is myriscv.

MARCH="${1:-myriscv}"
LLC="${LLC:-llc}"

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SMOKE_DIR="$ROOT_DIR/smoke"
OUT_DIR="$ROOT_DIR/out/smoke"

mkdir -p "$OUT_DIR"

failed=0
for ll in "$SMOKE_DIR"/*.ll; do
  base="$(basename "$ll" .ll)"
  out="$OUT_DIR/$base.s"
  echo "[SMOKE] $base -> $out"
  if ! "$LLC" -march="$MARCH" "$ll" -o "$out"; then
    echo "[FAIL] $base"
    failed=1
  fi
done

if [[ "$failed" -ne 0 ]]; then
  echo "Smoke codegen failed"
  exit 1
fi

echo "Smoke codegen passed"
