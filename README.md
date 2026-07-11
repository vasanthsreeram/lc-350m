# LC-350M — Lint Clean (dictation polish)

**LC-350M** (“Lint Clean”) is a small on-device model for **cleaning voice-dictation transcripts**.

It is fine-tuned from [LiquidAI/LFM2.5-350M](https://huggingface.co/LiquidAI/LFM2.5-350M) for MacWispr-style ASR cleanup: stutters, fillers, light grammar, and (optionally) spoken self-corrections.

| Variant | Role | Local path / HF name |
|---------|------|----------------------|
| **LC-350M-light** | Light polish — keep wording, fix mess | `models/LC-350M-light` → `vasanthsreeram/LC-350M-light` |
| **LC-350M-smart** | Course-correction — “bag no not bag, my phone” → “my phone” | `models/LC-350M-smart` → `vasanthsreeram/LC-350M-smart` |

> **Not the MacWispr app.** App: [vasanthsreeram/macwispr](https://github.com/vasanthsreeram/macwispr).  
> This repo holds **training material, scripts, and model packaging** for LC-350M.

## Product use

MacWispr polish modes (planned):

- **Off** — raw STT  
- **Light (LC-350M-light)** — default-safe cleanup  
- **Smart (LC-350M-smart)** — opt-in self-repair intelligence  

## Quick try (Apple Silicon + MLX)

```bash
pip install mlx-lm
mlx_lm.generate --model vasanthsreeram/LC-350M-smart \
  --prompt "I wanna get the bag no not not bag my phone"
```

Or load a local fused folder:

```bash
mlx_lm.generate --model ./models/LC-350M-smart --prompt "..."
```

## Training (how this was made)

Source experiments live under MacWispr `bench/polish_finetune/` and are mirrored here under `training/`.

1. **Teacher labels** — human/Grok-cleaned real MacWispr history  
2. **Synthetic spoken mess** — stutters, fillers, ASR-ish errors  
3. **Course-correction pairs** — mid-utterance repairs  
4. **LoRA on LFM2.5-350M MLX 4-bit** → fuse → LC-350M  

See [training/RECIPE.md](./training/RECIPE.md).

## Publish to Hugging Face

```bash
# one-time
hf auth login

./scripts/publish_hf.sh
```

Creates/updates:

- `https://huggingface.co/vasanthsreeram/LC-350M-light`
- `https://huggingface.co/vasanthsreeram/LC-350M-smart`

## Links

| Resource | URL |
|----------|-----|
| MacWispr app | https://github.com/vasanthsreeram/macwispr |
| Base model | https://huggingface.co/LiquidAI/LFM2.5-350M |
| This training + packaging repo | https://github.com/vasanthsreeram/lc-350m |

## License

- **Base weights:** Liquid AI LFM license (see LiquidAI model cards).  
- **Our adapters / fine-tune scripts / training recipes:** Apache-2.0 unless noted.  
- Fine-tuned weights inherit Liquid base license terms — check before commercial redistribution.

## Name

**LC-350M** = **L**int **C**lean, ~**350M** parameters.
