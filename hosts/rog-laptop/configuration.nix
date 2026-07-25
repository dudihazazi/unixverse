{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.asus-rog-gl552vw
    ../../modules/nixos/personal-base.nix
    ../../modules/nixos/desktop.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Host identity
  networking.hostName = "rog-laptop";
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "none";
  users.users.dizzi21.extraGroups = [ "networkmanager" ];
  networking.nameservers = [
    "9.9.9.9"
    "149.112.112.112"
    "2620:fe::fe"
    "2620:fe::9"
    "1.1.1.1"
    "1.0.0.1"
    "2606:4700:4700::1111"
    "2606:4700:4700::1001"
  ];

  # NVIDIA PRIME offload (Intel as primary)
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    prime.offload.enable = true;
    prime.offload.enableOffloadCmd = true;
  };

  # System version
  system.stateVersion = "26.05";
}
