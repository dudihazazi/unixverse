# modules/nixos/desktop.nix
{ config, pkgs, ... }:

{
  # X11 / Desktop
  services.xserver.enable = true;

  # KDE Plasma
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Zen Browser policies (Firefox-compatible)
  environment.etc."zen/policies/policies.json".text = builtins.toJSON {
    policies = {
      DisableAppUpdate = true;
      ExtensionSettings = {
        "*" = {
          installation_mode = "allowed";
        };
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
        "87677a2c52b84ad3a151a4a72f5bd3c4@jetpack" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/grammarly-1/latest.xpi";
        };
        "{036a55b4-5e72-4d05-a06c-cba2dfcc134a}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/traduzir-paginas-web/latest.xpi";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
        };
      };
    };
  };

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
