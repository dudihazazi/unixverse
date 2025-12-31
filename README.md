# unixverse

Opinionated but minimal NixOS + Home Manager setup for a single laptop today,
with room to scale to additional machines later.

## Quick context for new contributors/agents

- Single source of truth is `flake.nix`.
- Host-specific settings live under `hosts/<name>/`.
- Shared NixOS settings live under `modules/nixos/`.
- Home Manager is user-scoped in `home/dizzi21/`.
- Keep hardware- or machine-specific changes in the host folder.

## Layout

- `flake.nix`: entry point
- `hosts/rog-laptop/`: this machine (host-only settings + hardware)
- `modules/nixos/`: shared NixOS modules
- `home/dizzi21/`: Home Manager config (user-level)

## Add a new host

1. Create `hosts/<name>/configuration.nix`
2. Add the host in `flake.nix`
3. If needed, add host-specific hardware file next to `configuration.nix`

## NixOS rebuild

`sudo nixos-rebuild switch --flake ~/unixverse#rog-laptop`

## Conventions

- Keep `modules/nixos/base.nix` generic for all NixOS hosts.
- Keep `hosts/<name>/configuration.nix` for machine-specific settings only.
- Prefer small, focused changes with clear sections and ordering.
