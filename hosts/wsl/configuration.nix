{ ... }:

{
  imports = [
    ../../modules/nixos/base.nix
  ];

  networking.hostName = "wsl";

  wsl.enable = true;
  wsl.defaultUser = "dizzi21";

  system.stateVersion = "25.11";
}
