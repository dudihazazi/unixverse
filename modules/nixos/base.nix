# modules/nixos/base.nix
{ config, pkgs, ... }:

{
  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Networking
  networking.networkmanager.enable = true;

  # Locale & timezone
  time.timeZone = "Asia/Tokyo";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "id_ID.UTF-8";
    LC_IDENTIFICATION = "id_ID.UTF-8";
    LC_MEASUREMENT = "id_ID.UTF-8";
    LC_MONETARY = "id_ID.UTF-8";
    LC_NAME = "id_ID.UTF-8";
    LC_NUMERIC = "id_ID.UTF-8";
    LC_PAPER = "id_ID.UTF-8";
    LC_TELEPHONE = "id_ID.UTF-8";
    LC_TIME = "id_ID.UTF-8";
  };

  # Allow unfree packages globally
  nixpkgs.config.allowUnfree = true;

  # User account (generic policy, not hardware-specific)
  users.users.dizzi21 = {
    isNormalUser = true;
    description = "Dudi Hazazi";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # CLI-only system packages
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    jq
    ripgrep
    micro
    eza
    bat
    fd
    fzf
    zoxide
    httpie
    btop
    p7zip
  ];
}
