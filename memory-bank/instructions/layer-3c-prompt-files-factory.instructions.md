---
description: Layer 3C — Prompt Files Factory. Rules for *.prompt.md cards. Prompts orchestrate modes and instructions. Store prompts under memory-bank/prompts/.
---

# Layer 3C — Prompt Files Factory

Purpose

- Prompts are on-demand procedures. They call a chat mode (see [Layer 3B](./layer-3b-chatmodes-factory.instructions.md)), reuse instruction files (see [Layer 3A](./layer-3a-custom-instructions-factory.instructions.md)), define variables, and fix output shape.

Heading Contract

- No H1 in `.prompt.md` files. First header must be: `## Slash Command: /<stem> - <label>`; subsequent headers are `###` or lower.

Authoring Procedure

- Path: `memory-bank/prompts/<stem>.prompt.md`.
- Front-matter: `description`, optional `mode: ask | edit | agent` (default agent), and optional `model`/`tools` that do not contradict the selected mode.
- Body: one-paragraph operational state; `### Inputs`, `### Steps`, `### Outputs`; use relative links.

Verify & Bootstrap

- Ensure `memory-bank/prompts/` exists. Ensure referenced mode exists (Layer 3B) and referenced instruction files exist (Layer 3A) or create minimal stubs.

Review Gate

- Heading contract satisfied; no H1. No contradictions with the selected mode. Relative links only; outputs explicit.
