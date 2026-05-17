# unixverse

Opinionated but minimal NixOS + Home Manager setup.

This repo is a Nix flake that builds complete NixOS systems (plus Home Manager)
for the hosts defined in `flake.nix`.

## Supported hosts

- `rog-laptop` (regular NixOS install): `hosts/rog-laptop/`
- `wsl` (NixOS on WSL): `hosts/wsl/`

If you’re new to Nix, don’t worry: the steps below start from a fresh install.

## Prerequisites (fresh NixOS)

After you install NixOS (graphical ISO or minimal ISO), boot into your system
and ensure you can run `sudo`.

1. Install git (if it isn’t installed yet):

   `nix-shell -p git`

2. Enable flakes + nix-command (usually required on fresh installs).

   Edit `/etc/nix/nix.conf` and add:

   `experimental-features = nix-command flakes`

   Then restart nix:

   `sudo systemctl restart nix-daemon`

## Install this config (NixOS “bare metal” / normal VM)

These steps apply to the `rog-laptop` style install (i.e. not WSL).

1. Clone this repo (pick a location and stick to it):

   `git clone <YOUR_REPO_URL> ~/unixverse`

2. (Optional but recommended) Review what will change before switching:

   `sudo nixos-rebuild dry-build --flake ~/unixverse#rog-laptop`

3. Apply the configuration:

   `sudo nixos-rebuild switch --flake ~/unixverse#rog-laptop`

4. Reboot if you changed low-level things (bootloader, kernel, display stack):

   `sudo reboot`

## Install this config (WSL)

This flake also includes a `wsl` NixOS configuration based on `NixOS-WSL`.

1. Follow the upstream NixOS-WSL installation instructions to get a working
   NixOS-WSL instance.

2. Inside WSL, clone this repo:

   `git clone <YOUR_REPO_URL> ~/devs/unixverse`

3. Build/apply the WSL configuration:

   `sudo nixos-rebuild switch --flake ~/devs/unixverse#wsl`

## Common workflows

- **Build only (safe)**: `sudo nixos-rebuild build --flake ~/unixverse#rog-laptop`
- **Dry-run build plan**: `sudo nixos-rebuild dry-build --flake ~/unixverse#rog-laptop`
- **Update flake inputs** (changes `flake.lock`): `nix flake update --flake ~/unixverse`
- **Check flake evaluation**: `nix flake check --flake ~/unixverse`

## Repo map

- `flake.nix`: single source of truth (hosts/inputs)
- `hosts/<name>/`: machine-specific NixOS configuration
- `modules/nixos/`: shared NixOS modules
- `home/dizzi21/`: Home Manager configuration

## Add a new host

1. Create `hosts/<name>/configuration.nix`
2. Add the host to `nixosConfigurations` in `flake.nix`
3. Keep hardware quirks in `hosts/<name>/` (not in shared modules)

## Conventions

- Keep `modules/nixos/base.nix` generic for all NixOS hosts.
- Keep `hosts/<name>/configuration.nix` for machine-specific settings only.
- Prefer small, focused changes with clear sections and ordering.
