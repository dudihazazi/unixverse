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

  catppuccin.starship = {
    enable = true;
    flavor = "frappe";
  };

  programs.wezterm.enable = true;
  programs.zed-editor.enable = true;

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
