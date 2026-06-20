{ ... }:

{
  imports = [
    ../../modules/nixos/base.nix
  ];

  networking.hostName = "wsl";

  wsl.enable = true;
  wsl.defaultUser = "dizzi21";
  wsl.wslConf.network.generateResolvConf = false;

  system.stateVersion = "26.05";
}
