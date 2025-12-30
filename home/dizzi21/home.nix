{ config, pkgs, ... }:

{
  home.username = "dizzi21";
  home.homeDirectory = "/home/dizzi21";
  home.stateVersion = "25.11";

  # GUI apps (start small)
  home.packages = with pkgs; [
    vlc
    libreoffice-qt6-fresh
    zed-editor
  ];

  imports = [
    zen-browser.homeModules.default
  ];

  programs.zen-browser.enable = true;

}
