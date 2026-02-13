# pre-commit mirror for PSScriptAnalyzer

This repository provides pre-commit hooks that run
[PowerShell/PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer)
inside a Docker image.

For pre-commit: see https://github.com/pre-commit/pre-commit

## Hooks

Defined in `.pre-commit-hooks.yaml`:

- `pwsh-lint`: runs `Invoke-ScriptAnalyzer` recursively.
- `pwsh-format`: runs `Invoke-Formatter` for `*.ps*` files recursively.

Both hooks use `language: docker_image` and run from `ghcr.io/s-weigand/PSScriptAnalyzer:{tag}`.

## Usage

Add this to your `.pre-commit-config.yaml`:

```yaml
repos:
  - repo: https://github.com/s-weigand/pre-commit_mirrors-PSScriptAnalyzer
    rev: ""
    hooks:
      - id: pwsh-lint
      - id: pwsh-format
```

Then run:

```bash
pre-commit autoupdate
pre-commit install
pre-commit run --all-files
```
