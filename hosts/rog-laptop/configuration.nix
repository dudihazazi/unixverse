{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.asus-rog-gl552vw
    ../../modules/nixos/base.nix
    ../../modules/nixos/desktop.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Host identity
  networking.hostName = "rog-laptop";

  # NVIDIA PRIME offload (Intel as primary)
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    prime.offload.enable = true;
    prime.offload.enableOffloadCmd = true;
  };

  # System version
  system.stateVersion = "25.11";
}
