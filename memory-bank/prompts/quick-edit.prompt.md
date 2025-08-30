---
description: Fast scoped file edit via Baseline Dev mode.
mode: edit
---

<!-- memory-bank/prompts/quick-edit.prompt.md -->

# Quick Edit

This card activates “Scoped File Edit” under the Baseline Dev chat mode. It instructs the agent
to make a small, targeted change while honoring existing code style and project guardrails. Keep
responses concise and additive.

Use this when you have a specific change in a known file/region. The agent assumes edit
capabilities are available via Baseline Dev tools.

## Slash Command: /quick-edit - Scoped File Edit

Operational State

- Perform a small, focused change using the Baseline Dev chat mode and project instructions.

### Inputs

- ${selection}
- ${file}
- ${workspaceFolder}
- ${input:change}

### Steps

1. Open the referenced file and analyze the selected region.
2. Apply minimal, directly requested changes honoring existing code style.
3. If edits span multiple files, state assumptions and ask for confirmation.
4. Produce a concise diff and a brief rationale.

### Outputs

- A short rationale and either a unified diff or explicit file updates.

See also

- [Baseline Dev Mode](../chatmodes/baseline-dev.chatmode.md)
- [Layer 3A — Custom Instructions Factory](../instructions/layer-3a-custom-instructions-factory.instructions.md)
