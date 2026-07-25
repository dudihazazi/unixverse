{
  pkgs,
  inputs,
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
    ./base.nix
    inputs.spicetify-nix.homeManagerModules.default
    inputs.catppuccin.homeModules.default
  ];

  # Override editor for desktop
  programs.git.settings.core.editor = "zed --wait";

  # Desktop-specific shell aliases
  programs.zsh.shellAliases = {
    ns = "sudo nixos-rebuild switch --flake $HOME/devs/unixverse#rog-laptop";
    zed = "zeditor";
  };

  programs.starship.settings = import ./programs/starship.nix;

  # Themes
  catppuccin = {
    starship = {
      enable = true;
      flavor = "frappe";
    };

    wezterm = {
      apply = true;
      enable = true;
      flavor = "frappe";
      accent = "lavender";
    };

    zed = {
      enable = true;
      flavor = "frappe";
      accent = "lavender";

      icons = {
        enable = true;
        flavor = "frappe";
      };
    };
  };

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      config = config or {}
      if next(config) == nil and wezterm.config_builder then
        config = wezterm.config_builder()
      end

      config.font = wezterm.font("JetBrainsMono Nerd Font")
      config.font_size = 12.0
      config.default_prog = { "zsh" }

      return config
    '';
  };

  programs.zed-editor = {
    enable = true;
    userSettings = {
      terminal = {
        font_family = "JetBrainsMono Nerd Font";
        shell = {
          program = "${pkgs.zsh}/bin/zsh";
        };
      };
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      ui_font_size = 16;
      buffer_font_size = 15;
      tab_size = 2;
      soft_wrap = "editor_width";
      hard_tabs = false;
      format_on_save = "on";
      remove_trailing_whitespace_on_save = true;
      ensure_final_newline_on_save = true;
      languages = {
        Nix = {
          language_servers = [ "nixd" ];
        };
      };
    };
  };

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
  };

  # Desktop-only packages
  home.packages = with pkgs; [
    # Browsers
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    google-chrome

    # Media
    vlc

    # Utilities
    easyeffects
    flameshot
    obsidian
    rsync
    telegram-desktop

    # Work
    libreoffice-qt6-fresh
  ];
}
