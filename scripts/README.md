# Scripts

This directory contains idempotent, language-agnostic scripts. Running them multiple times is safe.

- `init.sh`: Verifies foundation files, ensures executable bits, initializes git when absent, and prints status with timestamp.

Guidelines
- Do not overwrite existing files unless a protocol step explicitly requires it.
- Keep scripts POSIX-compliant when possible.
