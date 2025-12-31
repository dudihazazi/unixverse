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

  # Zen Browser policies (Firefox-compatible)
  environment.etc."zen/policies/policies.json".text = builtins.toJSON {
    policies = {
      DisableAppUpdate = true;
      DNSOverHTTPS = {
        Enabled = true;
        ProviderURL = "https://dns.quad9.net/dns-query";
        Locked = true;
      };
      ExtensionSettings = {
        "*" = {
          installation_mode = "allowed";
        };
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4629131/ublock_origin-1.68.0.xpi";
        };
        "87677a2c52b84ad3a151a4a72f5bd3c4@jetpack" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4585019/grammarly_1-8.934.0.xpi";
        };
        "{036a55b4-5e72-4d05-a06c-cba2dfcc134a}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4455681/traduzir_paginas_web-10.1.1.1.xpi";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4640726/bitwarden_password_manager-2025.12.0.xpi";
        };
      };
    };
  };

  # System version
  system.stateVersion = "25.11";
}
