---
description: Layer 3A — Custom Instructions Factory; canonical rules for authoring *.instructions.md; single-source, atomic, link relatively, no external URLs.
---

# Layer 3A — Custom Instructions Factory

Purpose

- Define durable, reusable guardrails for all AI runs. Store every instructions file under `memory-bank/instructions/`.

Operating Principles

- One idea per bullet; language must be testable.
- Prefer linking to existing rules over repeating content.
- Idempotent behavior; do not overwrite existing files.
- Use only relative links; no placeholders or external URLs.

Authoring Procedure

- Path: `memory-bank/instructions/<topic>.instructions.md`.
- Front-matter must include `description`. Omit `applyTo` unless explicitly provided and immutable.
- Body uses short bulleted rules. Express conditions as “If X → Do Y”.
- Reference sibling rules Layer 3B (chatmodes factory) and Layer 3C (prompt files factory) when present; use relative links only if those files exist locally.

Verify & Bootstrap

- Create missing files only; avoid duplication by linking to existing rules.
- Do not alter any existing `applyTo` fields.
- Record brief changes in `memory-bank/progress.md`.

Review Gate

- `description` is concrete and present; no new/modified `applyTo` without approval.
- All links are relative and resolve; no external links.
- Content within concise size target and free of duplication.
