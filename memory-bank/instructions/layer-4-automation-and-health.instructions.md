---
description: Layer 4 — Automation, Validation, and Triad Health. Codifies supporting scripts, VS Code tasks, index wiring, and commit-policy instructions beyond Layers 1–3. Excludes the Next.js app under web/ and its generator script.
---

<!-- memory-bank/instructions/layer-4-automation-and-health.instructions.md -->

# Layer 4 — Automation, Validation, and Triad Health

Purpose

- Establish resilient automation around the triad (instructions, chat modes, prompts), wire editor tasks, and encode commit policy guidance so the system remains verifiable and predictable. Apply only additive, idempotent changes beyond Layers 1–3.

Scope & Exclusions

- Include: validator scripts, triad health script, VS Code tasks, memory-bank index, commit policy instructions, and slash-command utilities.

Operating Principles

- Idempotent and additive: create what is missing; never overwrite existing content.
- Keep logic close to the repository: use shell scripts and VS Code tasks.
- Use only relative links; no external URLs.
- Update `memory-bank/activeContext.md` and `memory-bank/progress.md` with concise notes.

Artifacts to Ensure

1) Validator Scripts (executable)

- `scripts/validate-memory-bank.sh`
  - Validates front-matter (`description`) and forbids external links for `memory-bank/instructions/*.instructions.md`.
  - Do not add or modify `applyTo` unless explicitly approved.
- `scripts/validate-chatmodes.sh`
  - Enforces front-matter and constraints per [Layer 3B](./layer-3b-chatmodes-factory.instructions.md):
    `tools: ['codebase', 'editFiles', 'fetch']` and `model: GPT-5 (Preview)` or `GPT-5 mini (Preview)` only.
  - Exactly one H1 in body; relative links only; no external URLs.
- `scripts/validate-prompts.sh`
  - Enforces [Layer 3C](./layer-3c-prompt-files-factory.instructions.md) heading contract:
    path marker comment matching filename, exactly one blank line, then H1; first H2 is the Slash Command.
  - Requires `description` in front-matter; forbids external links.

2) Triad Health Script

- `scripts/triad-health.sh`
  - Runs all three validators and summarizes inventory of instructions, chat modes, and prompts.
  - Verifies `.vscode/settings.json` references triad locations.
  - Exits non-zero on failures; prints a concise OK/FAIL summary.

3) VS Code Tasks (merge-append)

- Ensure `.vscode/tasks.json` contains tasks to run:
  - `Validate 3A Instructions` → `scripts/validate-memory-bank.sh`
  - `Validate 3B Chatmodes` → `scripts/validate-chatmodes.sh`
  - `Validate 3C Prompts` → `scripts/validate-prompts.sh`
  - `Triad Health Check` → `scripts/triad-health.sh`
  - `List Slash Commands` → `scripts/list-slash-commands.sh`
- Append missing tasks without removing or altering unrelated tasks.

4) Slash Commands Utility

- `scripts/list-slash-commands.sh` lists all prompt Slash Command headers for quick discovery.
- Keep it simple: grep prompt files for lines beginning with `## Slash Command:` and print them.

5) Memory-Bank Index

- Ensure `memory-bank/index.md` exists and lists:
  - Core factories: [Layer 3A](./layer-3a-custom-instructions-factory.instructions.md),
    [Layer 3B](./layer-3b-chatmodes-factory.instructions.md),
    [Layer 3C](./layer-3c-prompt-files-factory.instructions.md), and this Layer 4.
  - Current chat modes and prompt cards.
- Keep links relative; update additively.

6) Commit Policy Instructions

- Ensure the following instruction files exist under `memory-bank/instructions/` (create minimal stubs if missing):
  - `conventional-commits-must-be-used.instructions.md`
  - `commit-examples.instructions.md`
  - `breaking-changes-commits.instructions.md`
  - `gitmoji-complete-list.instructions.md`
- Ensure `.vscode/settings.json` references `conventional-commits-must-be-used.instructions.md` in
  `github.copilot.chat.commitMessageGeneration.instructions` without removing existing entries.

7) Prompt Contract Resilience

- Keep prompt heading rules synchronized with [Layer 3C](./layer-3c-prompt-files-factory.instructions.md):
  - Path marker comment → one blank line → H1 → first H2 is Slash Command.
- Maintain validator checks so regressions surface in CI/local runs.

Verify & Exit

- All scripts above are executable; validators pass; triad health returns OK.
- `.vscode/tasks.json` includes the listed tasks.
- `memory-bank/index.md` includes Layer 4.
- Memory updated: brief notes added to `activeContext.md` and `progress.md`.

