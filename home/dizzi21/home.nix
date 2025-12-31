{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Home Manager basics
  home.username = "dizzi21";
  home.homeDirectory = "/home/dizzi21";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  # Git + diffs
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "dudihazazi";
        email = "hazazi.dudi@gmail.com";
      };

      init.defaultBranch = "main";
      pull.rebase = false;
      core.editor = "zed --wait";
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

  # Shell
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
      # Safer defaults
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
      ns = "sudo nixos-rebuild switch --flake ~/unixverse#rog-laptop";
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

  # Prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = import ./starship.nix;
  };

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      return {
        font = wezterm.font("JetBrainsMono Nerd Font"),
        font_size = 12.0,
        default_prog = { "zsh" },
      }
    '';
  };

  xdg.configFile."zed/settings.json" = {
    force = true;
    text = ''
      {
        "terminal": {
          "font_family": "JetBrainsMono Nerd Font"
        },
        "telemetry": {
          "diagnostics": false,
          "metrics": false,
        },
        "icon_theme": {
          "mode": "system",
          "light": "Catppuccin Frappé",
          "dark": "Zed (Default)",
        },
        "ui_font_size": 16,
        "buffer_font_size": 15,
        "theme": {
          "mode": "dark",
          "light": "One Light",
          "dark": "Catppuccin Frappé",
        },
        "tab_size": 2,
        "soft_wrap": "editor_width",
        "indent_size": 2,
        "use_tab": false,
        "format_on_save": "on",
        "trim_trailing_whitespace_on_save": true,
        "insert_final_newline_on_save": true,
        "languages": {
          "Nix": {
            "language_servers": ["nixd"],
          },
        },
      }
    '';
  };

  # GUI apps (start small)
  home.packages = with pkgs; [
    # Browsers
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    vivaldi

    # Developer tooling (user-scoped)
    nodejs
    pnpm
    bun
    uv
    go
    rustup

    # Graphics
    gimp
    inkscape

    # Media
    spotify
    vlc

    # Utilities
    flameshot
    obsidian

    # Work
    libreoffice-qt6-fresh
    zed-editor
    nixd
    nixfmt-rfc-style
  ];
}
