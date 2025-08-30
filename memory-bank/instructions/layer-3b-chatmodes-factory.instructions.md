---
description: Layer 3B — Chat Modes Factory. Rules for *.chatmode.md files. Minimal modes that bind model + tools + behavior. Store modes under memory-bank/chatmodes/.
---

# Layer 3B — Chat Modes Factory

Purpose

- Modes are switches: they set `model` and `tools`, then defer to instructions. Keep text thin. Reference [Layer 3A](./layer-3a-custom-instructions-factory.instructions.md) for rules and [Layer 3C](./layer-3c-prompt-files-factory.instructions.md) for prompts.

Constraints

- Front-matter must include:
  - `description: <short>`
  - `tools: ['codebase', 'editFiles', 'fetch']` (exact)
  - `model: GPT-5 (Preview)` or `model: GPT-5 mini (Preview)` (only)
- Exactly one `#` H1 in the body. Relative links only. No external URLs.

Authoring Procedure

- Path for mode: `memory-bank/chatmodes/<name>.chatmode.md`.
- Body ≤ 200 words including: Purpose, Inputs expected, Output format, Boundaries.
- Link to instruction files under `memory-bank/instructions/` for detailed policy.

Verify & Bootstrap

- Create `memory-bank/chatmodes/` if missing. Do not modify an existing mode’s `tools` or `model` without explicit approval.
- Factor common text into an instructions file and link to it.

Review Gate

- Front-matter present and compliant.
- Body minimal, explicit inputs/outputs/boundaries.
- Only relative links; no duplication of instruction text.
