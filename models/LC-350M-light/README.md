---
license: other
license_name: lfm-open-license
base_model: LiquidAI/LFM2.5-350M
tags:
  - mlx
  - dictation
  - speech-to-text
  - cleanup
  - polish
  - apple-silicon
  - lfm
  - lc-350m
language:
  - en
library_name: mlx
pipeline_tag: text-generation
---

# LC-350M-light (Lint Clean)

Light on-device **dictation transcript cleanup** for Apple Silicon (MLX).

Fine-tuned from [LiquidAI/LFM2.5-350M](https://huggingface.co/LiquidAI/LFM2.5-350M) for MacWispr-style polish:

- Remove stutters / exact word repeats  
- Light grammar, punctuation, capitalization  
- **Keep meaning and almost all wording** (no heavy rewrite)

For spoken self-corrections (“bag no not bag, my phone”), use **[LC-350M-smart](https://huggingface.co/vasanth009/LC-350M-smart)** instead.

## Usage (MLX)

```bash
pip install mlx-lm
mlx_lm.generate --model vasanth009/LC-350M-light \
  --max-tokens 256 \
  --prompt "Clean this voice dictation lightly. Keep every idea.\n\nTranscript:\nsee we can improve the UI because currently it's it's glitching"
```

## Related

- Training repo: [github.com/vasanthsreeram/lc-350m](https://github.com/vasanthsreeram/lc-350m)  
- App: [github.com/vasanthsreeram/macwispr](https://github.com/vasanthsreeram/macwispr)  
- Smart variant: [LC-350M-smart](https://huggingface.co/vasanth009/LC-350M-smart)

## License

Inherits Liquid LFM base model terms. Training code in the GitHub repo is Apache-2.0.
