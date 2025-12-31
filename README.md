# unixverse

Minimal NixOS + Home Manager setup with room to grow across hosts (NixOS, macOS, WSL).

## Layout

- `flake.nix` : entry point
- `hosts/`
  - `rog-laptop/` : this machine
- `modules/`
  - `nixos/` : shared NixOS modules
- `home/`
  - `dizzi21/` : Home Manager config

## Add a new host

1. Create `hosts/<name>/configuration.nix`
2. Add the host in `flake.nix`
3. If needed, add host-specific hardware file next to `configuration.nix`

## NixOS rebuild

`sudo nixos-rebuild switch --flake ~/unixverse#nixos`
