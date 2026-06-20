{ ... }:

{
  imports = [
    ../../modules/nixos/base.nix
  ];

  networking.hostName = "wsl";

  wsl.enable = true;
  wsl.defaultUser = "dizzi21";
  wsl.wslConf.network.generateResolvConf = false;

  # WSL does not expose a real Wi-Fi stack, so avoid starting wpa_supplicant.
  systemd.services.wpa_supplicant.enable = false;
  system.stateVersion = "26.05";
}
