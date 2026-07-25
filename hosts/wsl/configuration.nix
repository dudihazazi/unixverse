{ ... }:

{
  imports = [
    ../../modules/nixos/personal-base.nix
  ];

  networking.hostName = "wsl";

  wsl.enable = true;
  wsl.defaultUser = "dizzi21";
  programs.nix-ld.enable = true;
  services.dbus.enable = true;
  users.users.dizzi21.linger = true;

  # WSL does not expose a real Wi-Fi stack, so avoid starting wpa_supplicant.
  systemd.services.wpa_supplicant.enable = false;
  system.stateVersion = "26.05";
}
