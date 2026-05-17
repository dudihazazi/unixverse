{
  pkgs,
  lib,
  pkgsUnstable,
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
      gc = "git commit";
      gco = "git checkout";
      gd = "git diff";
      gl = "git log --oneline --decorate --graph";
      gp = "git pull";
      gps = "git push";
      gst = "git status -sb";

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

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  home.activation.ohMyOpenCode = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    config_file="$HOME/.config/opencode/opencode.json"
    if [ ! -f "$config_file" ] || ! grep -q '"oh-my-opencode"' "$config_file"; then
      export PATH="${pkgs.opencode}/bin:${pkgsUnstable.bun}/bin:$PATH"
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
    opencode
    nixd
    nixfmt-rfc-style
  ];
}
