{
  config,
  pkgs,
  inputs,
  pkgsUnstable,
  ...
}:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  spicyLyricsSrc = pkgs.fetchFromGitHub {
    owner = "Spikerko";
    repo = "spicy-lyrics";
    rev = "2de7a609bdead1ade90addde2b1d551d4b87e87a";
    hash = "sha256-VEMxk9Hjtuh5fRYt0LzOhkd34sr2i6e6FFM55FJHz98=";
  };
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

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

  # KDE Plasma (minimal declarative setup)
  xdg.configFile."kdeglobals".text = ''
    [General]
    ColorScheme=Ant-Dark
    TerminalApplication=wezterm start --cwd .
    TerminalService=org.wezfurlong.wezterm.desktop
    fixed=JetBrainsMono Nerd Font Mono,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1

    [Icons]
    Theme=Papirus-Dark

    [KDE]
    LookAndFeelPackage=Ant-Dark
    widgetStyle=Breeze
  '';

  xdg.configFile."plasmarc".text = ''
    [Theme]
    name=Ant-Dark
  '';

  xdg.configFile."ksplashrc".text = ''
    [KSplash]
    Theme=a2n.kuro
  '';

  xdg.configFile."kwinrc".text = ''
    [Desktops]
    Number=1
    Rows=1

    [NightColor]
    Active=true
    NightTemperature=4000
  '';

  programs.spicetify = {
    enable = true;
    spotifyPackage = pkgs.spotify;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      {
        name = "spicy-lyrics.mjs";
        src = "${spicyLyricsSrc}/builds";
      }
    ];
    enabledCustomApps = with spicePkgs.apps; [
      marketplace
    ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "frappe";
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
    gh
    pkgsUnstable.codex

    # Graphics
    gimp
    inkscape

    # Media
    spicetify-cli
    vlc

    # Utilities
    easyeffects
    flameshot
    obsidian

    # Work
    libreoffice-qt6-fresh
    zed-editor
    nixd
    nixfmt-rfc-style
  ];
}
