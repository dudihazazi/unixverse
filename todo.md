# NixOS + Home Manager — Remaining TODOs

This file lists remaining and optional TODOs after completing:
- Flakes
- Modular NixOS
- Home Manager integration
- Git (declarative)
- Zsh + Starship (Catppuccin, powerline)
- Fonts
- Core GUI apps

Status: stable daily-driver baseline achieved

---

## 1. Shell — Final Polish (High Priority)

### 1.1 Enable zoxide (recommended) ✅
- Keep `cd` unchanged
- Use `z` / `zi` for smart jumps

Home Manager config:

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

---

### 1.2 Add useful aliases (if not yet added) ✅

Goals:
- Faster navigation
- Safer file operations
- Common Nix shortcuts

Example aliases:

    programs.zsh.shellAliases = {
      ls = "eza --icons --group-directories-first";
      ll = "eza -lah --icons --group-directories-first";
      cat = "bat";
      grep = "rg";
      find = "fd";

      ".." = "cd ..";
      "..." = "cd ../..";

      ns = "sudo nixos-rebuild switch --flake .#nixos";
    };

---

### 1.3 Optional: history keybindings
- Use ↑ / ↓ to search history by prefix
- Quality-of-life only, not required

---

## 2. direnv + nix-direnv (Very High Value) ✅

Purpose:
- Project-local development environments
- Clean Node / Rust / Python later
- No shell pollution

TODO:
- Enable programs.direnv
- Enable nix-direnv
- Add .envrc per project

---

## 3. Developer Tooling (User-Scoped, After direnv)

Add only after direnv is working.

Candidates:
- Node.js (with pnpm)
- Python (uv / poetry)
- Go / Rust

Design rules:
- Tools live in Home Manager
- Environments activated via direnv
- No global language pollution

---

## 4. Terminal Emulator (Optional)

Current:
- Konsole (working fine)

Alternatives:
- Kitty → performance
- WezTerm → cross-platform future

Decision:
- Optional
- Zero shell refactor required

---

## 5. Home Manager Modularization (Later)

Only do this when configs stabilize.

Future structure:

    home/modules/
      shell.nix
      git.nix
      starship.nix
      gui.nix
      dev.nix

Not required yet.

---

## 6. Catppuccin Nix Integration (Blocked for now)

Status:
- Catppuccin Nix not released for 25.11

Current approach:
- Starship: manual Catppuccin palette (done)
- Zed: Catppuccin extension
- Konsole: Catppuccin color scheme

Future TODO:
- Revisit when Catppuccin supports 25.11
- Replace per-app theming with module

---

## 7. Cross-Platform Prep (Future)

Optional, no urgency:
- WSL profile
- nix-darwin profile
- Shared Home Manager modules

---

## 8. Maintenance / Cleanup (Low Priority)

- Watch for deprecated options
- Keep flake inputs minimal
- Periodic `nix flake update`
- Commit after each logical step

---

## Recommended Next Step

Developer tooling (Node/Bun/Python/Go/Rust) via direnv

This unlocks the entire dev-tooling layer cleanly.
