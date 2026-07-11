#!/usr/bin/env bash
# Publish LC-350M fused MLX models to Hugging Face (separate from MacWispr app).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
USER="${HF_USER:-vasanthsreeram}"

if ! hf auth whoami &>/dev/null; then
  echo "Not logged in to Hugging Face."
  echo "In this shell run:  hf auth login"
  echo "(You mentioned cmux is logged in — use that terminal or export HF_TOKEN.)"
  exit 1
fi

who="$(hf auth whoami 2>/dev/null | head -1 || true)"
echo "Logged in as: $who"
echo "Publishing under user/org: $USER"

publish_one() {
  local local_dir="$1"
  local repo_id="$2"
  local name="$3"
  echo ""
  echo "=== $name → $repo_id ==="
  if [[ ! -d "$local_dir" ]]; then
    echo "Missing $local_dir — fuse models first."
    exit 1
  fi
  # Create model repo if needed (ignore if exists)
  hf repo create "$repo_id" --type model --private false 2>/dev/null || true
  hf upload "$repo_id" "$local_dir" . --repo-type model
  echo "https://huggingface.co/$repo_id"
}

publish_one "$ROOT/models/LC-350M-light" "$USER/LC-350M-light" "LC-350M-light"
publish_one "$ROOT/models/LC-350M-smart" "$USER/LC-350M-smart" "LC-350M-smart"

# Also upload LoRA adapters (tiny) for people who load base LFM + adapter
ADAPTER_SRC="${MACWISPR_BENCH:-$ROOT/../macwispr/bench/polish_finetune/adapters}"
if [[ -d "$ADAPTER_SRC/lfm350-polish-teacher" ]]; then
  echo ""
  echo "=== Adapters (optional small package) ==="
  hf repo create "$USER/LC-350M-adapters" --type model --private false 2>/dev/null || true
  mkdir -p /tmp/lc350-adapters/{light,smart}
  cp -R "$ADAPTER_SRC/lfm350-polish-teacher/adapters.safetensors" \
        "$ADAPTER_SRC/lfm350-polish-teacher/adapter_config.json" /tmp/lc350-adapters/light/ 2>/dev/null || true
  cp -R "$ADAPTER_SRC/lfm350-smart-course/adapters.safetensors" \
        "$ADAPTER_SRC/lfm350-smart-course/adapter_config.json" /tmp/lc350-adapters/smart/ 2>/dev/null || true
  printf '%s\n' "# LC-350M LoRA adapters for LiquidAI/LFM2.5-350M-MLX-4bit" \
    "Base: LiquidAI/LFM2.5-350M-MLX-4bit" \
    "See https://github.com/vasanthsreeram/lc-350m" > /tmp/lc350-adapters/README.md
  hf upload "$USER/LC-350M-adapters" /tmp/lc350-adapters . --repo-type model
fi

echo ""
echo "Done."
echo "  https://huggingface.co/$USER/LC-350M-light"
echo "  https://huggingface.co/$USER/LC-350M-smart"
