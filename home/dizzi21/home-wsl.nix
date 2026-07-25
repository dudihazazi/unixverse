{
  ...
}:

{
  imports = [
    ./base.nix
  ];

  # WSL has no user D-Bus session during system activation.
  systemd.user.startServices = false;

  # Override editor for WSL
  programs.git.settings.core.editor = "micro";

  programs.starship.settings = import ./programs/starship.nix;

  # WSL-specific shell aliases
  programs.zsh.shellAliases = {
    ns = "sudo nixos-rebuild switch --flake ~/devs/unixverse#wsl";
  };
}
