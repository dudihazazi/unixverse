# modules/nixos/personal-base.nix
{ pkgs, ... }:

{
  # Nix settings
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.auto-optimise-store = true;
  nixpkgs.config.allowUnfree = true;

  # Nix store maintenance
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

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

  # Users and shells
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  users.users.dizzi21 = {
    isNormalUser = true;
    description = "Dudi Hazazi";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];

  fonts.fontconfig.defaultFonts = {
    monospace = [
      "JetBrainsMono Nerd Font"
      "Noto Sans Mono CJK JP"
    ];
    sansSerif = [
      "Noto Sans CJK JP"
      "Noto Sans"
    ];
    serif = [
      "Noto Serif CJK JP"
      "Noto Serif"
    ];
  };

  # CLI-only system packages
  environment.systemPackages = with pkgs; [
    # Core tools
    bat
    btop
    curl
    eza
    fd
    fzf
    git
    jq
    lazygit
    micro
    procs
    ripgrep
    tokei
    xh
    yq-go
    zoxide
    wget
    # Storage
    duf
    dust
    # Archives
    p7zip
    unzip
    zip
  ];
}
