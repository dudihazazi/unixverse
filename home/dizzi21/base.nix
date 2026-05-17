{
  pkgs,
  lib,
  pkgsUnstable,
  opencodePkg ? pkgsUnstable.opencode,
  ...
}:

{
  home.username = "dizzi21";
  home.homeDirectory = "/home/dizzi21";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "dudihazazi";
        email = "hazazi.dudi@gmail.com";
      };
      init.defaultBranch = "main";
      pull.rebase = false;
      push.autoSetupRemote = true;
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      line-numbers = true;
      side-by-side = true;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      save = 10000;
      share = true;
    };

    shellAliases = {
      # Better defaults
      mkdir = "mkdir -p";

      # Better ls
      ls = "eza --icons --group-directories-first";
      ll = "eza -lah --icons --group-directories-first";
      la = "eza -a --icons --group-directories-first";
      lt = "eza --tree --level=2 --icons";

      # Better cat
      cat = "bat";

      # Better find/grep
      find = "fd";
      grep = "rg";

      # Git shortcuts
      g = "git";
      ga = "git add";
      gaa = "git add --all";
      gap = "git add --patch";
      gb = "git branch";
      gc = "git commit";
      gcm = "git commit -m";
      gco = "git checkout";
      gd = "git diff";
      gf = "git fetch";
      gfa = "git fetch --all --prune";
      gl = "git log --oneline --decorate --graph";
      gm = "git merge";
      gp = "git pull";
      gpl = "git pull";
      gps = "git push";
      gpf = "git push --force-with-lease";
      grb = "git rebase";
      grba = "git rebase --abort";
      grbc = "git rebase --continue";
      grbi = "git rebase -i";
      gs = "git switch";
      gsc = "git switch -c";
      gsh = "git show";
      gst = "git status -sb";
      gwt = "git worktree";
      gwta = "git worktree add";
      gwtl = "git worktree list";
      gwtr = "git worktree remove";

      # GitHub CLI shortcuts
      ghpr = "gh pr";
      ghprc = "gh pr create";
      ghprco = "gh pr checkout";
      ghprs = "gh pr status";
      ghprv = "gh pr view --web";
      ghrepo = "gh repo";

      # Navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";

      # Nix shortcuts
      nb = "nix build";
      nd = "nix develop";
      nf = "nix flake";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  home.activation.ohMyOpenCode = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    config_file="$HOME/.config/opencode/opencode.json"
    if [ ! -f "$config_file" ] || ! grep -q '"oh-my-opencode"' "$config_file"; then
      export PATH="${opencodePkg}/bin:${pkgsUnstable.bun}/bin:$PATH"
      "${pkgsUnstable.bun}/bin/bunx" oh-my-opencode install --no-tui --claude=no --gemini=no --copilot=no || true
    fi
  '';

  home.packages = with pkgs; [
    # Developer tooling
    pkgsUnstable.nodejs
    pkgsUnstable.pnpm
    pkgsUnstable.bun
    pkgsUnstable.uv
    pkgsUnstable.go
    pkgsUnstable.rustup
    pkgsUnstable.gh
    pkgsUnstable.codex
    opencodePkg
    nixd
    nixfmt-rfc-style
  ];
}
