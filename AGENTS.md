# AGENTS.md — unixverse

This repository is a Nix Flake-based NixOS + Home Manager configuration.
Agents should optimize for safe, reviewable, minimal diffs.

## Repository Map

- `flake.nix` is the single source of truth for the flake.
- `hosts/<name>/` contains host-specific settings (machine-only).
- `modules/nixos/` contains shared NixOS modules.
- `home/<user>/` contains Home Manager user-level configuration.

**Hard rule**: keep hardware- or machine-specific changes in `hosts/<name>/`.
**Hard rule**: keep `modules/nixos/base.nix` generic for all NixOS hosts.

## Common Commands

### NixOS rebuild (primary workflow)

- Switch (apply changes):
  - From repo root: `sudo nixos-rebuild switch --flake .#rog-laptop`
  - From anywhere: `sudo nixos-rebuild switch --flake ~/unixverse#rog-laptop`

- Build only (no switch):
  - From repo root: `sudo nixos-rebuild build --flake .#rog-laptop`
  - From anywhere: `sudo nixos-rebuild build --flake ~/unixverse#rog-laptop`

- Test (activate temporarily):
  - From repo root: `sudo nixos-rebuild test --flake .#rog-laptop`
  - From anywhere: `sudo nixos-rebuild test --flake ~/unixverse#rog-laptop`

- Dry build (evaluate/build plan):
  - From repo root: `sudo nixos-rebuild dry-build --flake .#rog-laptop`
  - From anywhere: `sudo nixos-rebuild dry-build --flake ~/unixverse#rog-laptop`

### Flake operations

- Check flake outputs/evaluation:
  - `nix flake check`

- Show flake outputs:
  - `nix flake show`

- Update inputs (changes `flake.lock`):
  - `nix flake update`

### Home Manager (context)

Home Manager is integrated via NixOS modules in `flake.nix`.
Prefer applying user configuration via `nixos-rebuild` rather than invoking
Home Manager directly, unless you intentionally decouple it.

### Aliases (in the configured system)

The user configuration defines helpful aliases in `home/dizzi21/home.nix`:
- `ns` → `sudo nixos-rebuild switch --flake ~/unixverse#rog-laptop`
- `nb` → `nix build`
- `nd` → `nix develop`
- `nf` → `nix flake`

Do not rely on aliases in CI or agent scripts; use the full commands.

## Lint / Format / Tests

### Formatting Nix

- Formatter: `nixfmt-rfc-style` (installed via Home Manager packages).
- Format a single file:
  - `nixfmt path/to/file.nix`
- Format all Nix files in the repo (requires `fd`):
  - `fd -e nix -x nixfmt`

### Linting

There is no dedicated linter configured in this repo (no statix/deadnix).
Use `nix flake check` for evaluation-level validation.

### Tests / "run a single test"

This repo is primarily configuration; there are no unit tests.
The closest equivalents to a "single test" are targeted evaluations/builds:

- Evaluate/build only this host (no switch):
  - `sudo nixos-rebuild build --flake ~/unixverse#rog-laptop`
  - From repo root: `nix build .#nixosConfigurations.rog-laptop.config.system.build.toplevel`

- Evaluate the flake (all checks):
  - `nix flake check`


If adding checks/tests, prefer adding `checks` outputs to `flake.nix` and keep
them deterministic.

## Code Style (Nix)

### Formatting & layout

- Indentation: 2 spaces, no tabs.
- Prefer one attribute/value per line for longer sets/lists.
- Keep lists vertical when they have multiple entries.
- Use unix newlines and end files with a final newline.

### Imports & module structure

- NixOS modules typically begin with:
  - `{ config, pkgs, ... }:`
- Home Manager modules typically include extra args as needed:
  - `{ config, pkgs, inputs, lib, pkgsUnstable, ... }:`
- Put `imports = [ ... ];` near the top of a module.
- Use relative paths for imports.

### Naming conventions

- Directories: kebab-case (e.g. `rog-laptop`).
- Files: lowercase, kebab-case where it helps readability.
- Attributes: follow upstream option names (generally camelCase/snake_case as
  dictated by NixOS/Home Manager).

### Organization & separation of concerns

- Keep `modules/nixos/base.nix` generic and reusable.
- Keep `modules/nixos/desktop.nix` focused on desktop-related services.
- Keep `hosts/<name>/configuration.nix` for machine-specific settings:
  - hardware quirks, hostnames, device-specific services
- Keep user programs/settings in `home/<user>/home.nix`.

### Types and correctness

- Prefer explicit values over implicit defaults when it improves clarity.
- Avoid adding unused arguments in module parameter lists.
- Prefer `let ... in` only when it meaningfully reduces duplication.

### Error handling

Most Nix evaluation failures are best handled by:
- keeping expressions simple,
- avoiding partial functions where possible,
- using `lib.mkIf`/`lib.mkMerge`/`lib.mkDefault` appropriately,
- validating with `nix flake check` and `nixos-rebuild build`.

## Change Management

- Make small, focused commits (if/when committing is requested).
- Avoid refactors while doing a functional change.
- When touching host configuration, confirm whether the change should be
  host-specific or shared in a module.

## Cursor / Copilot Rules

No Cursor rules were found (`.cursor/rules/` or `.cursorrules`).
No GitHub Copilot instructions were found (`.github/copilot-instructions.md`).

## Notes for Agentic Tools

- Do not run destructive commands unless explicitly requested.
- Prefer `nixos-rebuild build` (or `nixos-rebuild test`) before `switch` for risky changes.
- Keep secrets out of the repo (no tokens, API keys, or private host details).
