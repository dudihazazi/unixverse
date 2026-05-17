{
  pkgs,
  lib,
  pkgsUnstable,
  ...
}:

let
  opencodePinned = pkgs.stdenvNoCC.mkDerivation {
    pname = "opencode";
    version = "1.14.25";

    src = pkgs.fetchurl {
      url = "https://github.com/anomalyco/opencode/releases/download/v1.14.25/opencode-linux-x64.tar.gz";
      hash = "sha256-ZULblz+/QEcH0nXYJPzX7vIKgAN4gRTrhQZ0Atr3MNs=";
    };

    nativeBuildInputs = [ pkgs.gnutar ];

    unpackPhase = ''
      tar -xf $src
    '';

    installPhase = ''
      install -Dm755 opencode $out/bin/opencode
    '';

    meta = {
      description = "AI coding agent built for the terminal";
      homepage = "https://github.com/anomalyco/opencode";
    };
  };
in
{
  _module.args.opencodePkg = opencodePinned;

  imports = [
    ./base.nix
  ];

  # Override editor for WSL
  programs.git.settings.core.editor = "micro";

  programs.starship.settings = import ./programs/starship-min.nix;

  # WSL-specific shell aliases
  programs.zsh.shellAliases = {
    ns = "sudo nixos-rebuild switch --flake ~/devs/unixverse#wsl";
    nfu = "sudo nix flake update ~/devs/unixverse";
  };
}
