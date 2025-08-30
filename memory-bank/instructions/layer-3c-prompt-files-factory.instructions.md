---
description: Layer 3C — Prompt Files Factory. Rules for *.prompt.md cards. Prompts orchestrate modes and instructions. Store prompts under memory-bank/prompts/.
---

# Layer 3C — Prompt Files Factory

Purpose

- Prompts are on-demand procedures. They call a chat mode (see [Layer 3B](./layer-3b-chatmodes-factory.instructions.md)), reuse instruction files (see [Layer 3A](./layer-3a-custom-instructions-factory.instructions.md)), define variables, and fix output shape.

Heading Contract

- Place a path marker comment immediately after front-matter:
  `<!-- memory-bank/prompts/<stem>.prompt.md -->`, followed by exactly one blank line.
- Begin the body with a single `#` H1 title that names the card.
- The next required section is `## Slash Command: /<stem> - <label>`.
- Subsequent headers are `###` or lower. Use only relative links; no external URLs.

Authoring Procedure

- Path: `memory-bank/prompts/<stem>.prompt.md`.
- Front-matter: required `description`; optional `mode: ask | edit | agent` (default agent), and optional `model`/`tools` that do not contradict the selected mode. Preserve existing optional keys.
- After the H1, include 1–2 short paragraphs that clearly describe the task and explicitly state the agent’s assumed mode/state for this card.
- Body must then include `## Slash Command: /<stem> - <label>` followed by sections: `### Inputs`, `### Steps`, `### Outputs`. Use only relative links.

Verify & Bootstrap

- Ensure `memory-bank/prompts/` exists. Ensure referenced mode exists (Layer 3B) and referenced instruction files exist (Layer 3A) or create minimal stubs.

Review Gate

- Path marker comment present and matches filename; exactly one blank line before the H1 title.
- H1 present, followed by 1–2 intro paragraphs describing task and agent state.
- First H2 is the Slash Command heading. Subsequent sections include Inputs, Steps, and Outputs.
- Relative links only; outputs explicit; no external URLs.
