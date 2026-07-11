---
license: other
license_name: lfm-open-license
base_model: LiquidAI/LFM2.5-350M
tags:
  - mlx
  - dictation
  - speech-to-text
  - cleanup
  - course-correction
  - apple-silicon
  - lfm
  - lc-350m
language:
  - en
library_name: mlx
pipeline_tag: text-generation
---

# LC-350M-smart (Lint Clean · course-correction)

On-device **dictation cleanup with spoken self-repairs** for Apple Silicon (MLX).

Fine-tuned from [LiquidAI/LFM2.5-350M](https://huggingface.co/LiquidAI/LFM2.5-350M).

Example:

| Raw ASR | Clean |
|---------|--------|
| I wanna get the bag no not not bag my phone | I want to get my phone. |
| we should use Qwen wait no use Parakeet V3 | We should use Parakeet V3. |

Use **[LC-350M-light](https://huggingface.co/vasanthsreeram/LC-350M-light)** for conservative polish without aggressive rewrites.

## Usage (MLX)

```bash
pip install mlx-lm
mlx_lm.generate --model vasanthsreeram/LC-350M-smart \
  --max-tokens 128 \
  --prompt "Clean this voice dictation into what the speaker finally meant.\n\nI wanna get the bag no not not bag my phone"
```

## Related

- Training repo: [github.com/vasanthsreeram/lc-350m](https://github.com/vasanthsreeram/lc-350m)  
- App: [github.com/vasanthsreeram/macwispr](https://github.com/vasanthsreeram/macwispr)  
- Light variant: [LC-350M-light](https://huggingface.co/vasanthsreeram/LC-350M-light)

## License

Inherits Liquid LFM base model terms. Training code in the GitHub repo is Apache-2.0.
