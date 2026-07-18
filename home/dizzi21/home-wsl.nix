{
  lib,
  ...
}:

{
  imports = [
    ./base.nix
  ];

  unixverse.programs.opencode.settings.mcp.pencil = {
    type = "local";
    enabled = true;
    command = [
      "/home/dizzi21/.pencil/mcp/visual_studio_code/out/mcp-server-linux-x64"
      "--app"
      "visual_studio_code"
    ];
    env = { };
    timeout = 30000;
  };

  # Override editor for WSL
  programs.git.settings.core.editor = "micro";

  programs.starship.settings = import ./programs/starship-min.nix;

  # WSL-specific shell aliases
  programs.zsh.shellAliases = {
    ns = "sudo nixos-rebuild switch --flake ~/devs/unixverse#wsl";
    nfu = "sudo nix flake update ~/devs/unixverse";
  };
}
