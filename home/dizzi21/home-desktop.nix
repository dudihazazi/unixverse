{
  pkgs,
  inputs,
  ...
}:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  unstablePkgs = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  spicyLyricsSrc = pkgs.fetchFromGitHub {
    owner = "Spikerko";
    repo = "spicy-lyrics";
    rev = "2de7a609bdead1ade90addde2b1d551d4b87e87a";
    hash = "sha256-VEMxk9Hjtuh5fRYt0LzOhkd34sr2i6e6FFM55FJHz98=";
  };
  spicyLyricTranslatorSrc = pkgs.fetchFromGitHub {
    owner = "7xeh";
    repo = "SpicyLyricTranslator";
    rev = "ee990a59e3a20dff6966929dfc6e1ff59305652d";
    hash = "sha256-C/1c0hiZwXBC/Y2Su7hNaBamXSoZrav8UGbapKKiayI=";
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

  programs.ghostty.enable = true;
  programs.zed-editor.enable = true;

  programs.spicetify = {
    enable = true;
    spotifyPackage = pkgs.spotify;
    spicetifyPackage = unstablePkgs.spicetify-cli;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "macchiato";
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      {
        name = "spicy-lyrics.mjs";
        src = "${spicyLyricsSrc}/builds";
      }
      {
        name = "spicy-lyric-translater.js";
        src = pkgs.runCommand "spicy-lyric-translator-loader" { } ''
          mkdir -p "$out"
          cp ${spicyLyricTranslatorSrc}/loader/SLT-loader.js "$out/spicy-lyric-translater.js"
        '';
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
    loupe

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
