---
description: Fast scoped file edit via Baseline Dev mode.
mode: edit
---

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
