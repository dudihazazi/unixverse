{
  pkgs,
  inputs,
  lib,
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
    ./base.nix
    inputs.spicetify-nix.homeManagerModules.default
    inputs.catppuccin.homeModules.default
  ];

  # Override editor for desktop
  programs.git.settings.core.editor = "zed --wait";

  # Desktop-specific shell aliases
  programs.zsh.shellAliases = {
    ns = "sudo nixos-rebuild switch --flake ~/Documents/projects/unixverse#rog-laptop";
    nfu = "sudo nix flake update ~/Documents/projects/unixverse";
    zed = "zeditor";
  };

  programs.starship.settings = import ./starship-fancy.nix;

  # Themes
  catppuccin = {
    kvantum = {
      apply = true;
      enable = true;
      flavor = "frappe";
      accent = "lavender";
    };

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

  qt = {
    enable = true;
    style.name = "kvantum";
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
    package = pkgsUnstable.zed-editor;
    userSettings = {
      terminal = {
        font_family = "JetBrainsMono Nerd Font";
        shell = "${pkgs.zsh}/bin/zsh";
      };
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      ui_font_size = 16;
      buffer_font_size = 15;
      tab_size = 2;
      soft_wrap = "editor_width";
      indent_size = 2;
      use_tab = false;
      format_on_save = "on";
      trim_trailing_whitespace_on_save = true;
      insert_final_newline_on_save = true;
      languages = {
        Nix = {
          language_servers = [ "nixd" ];
        };
      };
    };
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
    widgetStyle=kvantum
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

  # Desktop-only packages
  home.packages = with pkgs; [
    # Browsers
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    vivaldi

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
    telegram-desktop

    # Theming
    kdePackages.qtstyleplugin-kvantum

    # Work
    libreoffice-qt6-fresh
    pkgsUnstable.zed-editor
  ];
}
