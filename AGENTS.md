# Repository Guidelines

## Project Structure & Module Organization
- `flake.nix` is the single entry point; `flake.lock` pins inputs.
- Host-specific configuration lives in `hosts/<name>/` (current host: `hosts/rog-laptop/`).
- Shared NixOS modules live in `modules/nixos/` (keep these host-agnostic).
- Home Manager configuration is user-scoped in `home/dizzi21/`.
- Example path for a host change: `hosts/rog-laptop/configuration.nix`.

## Build, Test, and Development Commands
- `sudo nixos-rebuild switch --flake ./#rog-laptop` applies the full system + Home Manager configuration.
- `sudo nixos-rebuild build --flake ./#rog-laptop` validates configuration without switching.
- `nix flake update` refreshes input pins in `flake.lock` (review diffs carefully).
- Optional formatting (if installed): `nix run nixpkgs#nixfmt-rfc-style -- .`.

## Coding Style & Naming Conventions
- Nix files use 2-space indentation and trailing semicolons; keep layout consistent with existing files.
- Keep machine-specific settings in `hosts/<name>/configuration.nix` and shared defaults in `modules/nixos/`.
- Prefer small, focused changes with clear ordering of options and sections.

## Testing Guidelines
- No automated test suite is defined for this repo.
- Validate changes with a build before switching: `sudo nixos-rebuild build --flake ./#rog-laptop`.
- If you modify Home Manager files, ensure the system rebuild completes without evaluation errors.

## Commit & Pull Request Guidelines
- Commit messages follow a Conventional Commits-style prefix (e.g., `feat:`, `fix:`, `chore:`).
- PRs should describe the affected host(s), include the rebuild command used, and call out risky changes.
- Link related issues or TODOs and note any required follow-up steps.
