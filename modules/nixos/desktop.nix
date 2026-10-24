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

  # COSMIC desktop and login screen
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;
  security.pam.services.cosmic-greeter.enableGnomeKeyring = true;

  # Use the Home Manager OpenSSH agent instead of GCR's SSH agent.
  services.gnome.gcr-ssh-agent.enable = false;

  # Keyboard layout (also used by COSMIC)
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
