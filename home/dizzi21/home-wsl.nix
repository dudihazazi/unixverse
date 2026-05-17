{
  pkgs,
  lib,
  pkgsUnstable,
  ...
}:

{
  imports = [
    ./base.nix
  ];

  # Override editor for WSL
  programs.git.settings.core.editor = "micro";

  programs.starship.settings = import ./starship-min.nix;

  # WSL-specific shell aliases
  programs.zsh.shellAliases = {
    ns = "sudo nixos-rebuild switch --flake ~/devs/unixverse#wsl";
    nfu = "sudo nix flake update ~/devs/unixverse";
  };
}
