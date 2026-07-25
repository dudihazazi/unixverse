# modules/nixos/desktop.nix
{ pkgs, ... }:

{
  programs.nix-ld.enable = true;

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

  # X11 / Desktop
  services.xserver.enable = true;

  # KDE Plasma
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # X11 keymap
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Printing
  services.printing.enable = true;

  # Audio (PipeWire)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true; # enable only if you need JACK
  };

}
