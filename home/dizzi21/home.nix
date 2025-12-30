{ config, pkgs, inputs, ... }:

{
  home.username = "dizzi21";
  home.homeDirectory = "/home/dizzi21";
  home.stateVersion = "25.11";

  # GUI apps (start small)
  home.packages = with pkgs; [
    # Browsers
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    vivaldi

    # Graphics
    gimp
    inkscape

    # Media
    spotify
    vlc

    # Utilities
    flameshot
    obsidian

    # Works
    libreoffice-qt6-fresh
    zed-editor

  ];

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

  programs.home-manager.enable = true;

}
