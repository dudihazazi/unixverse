{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  json = value: (builtins.toJSON value) + "\n";
  opencodePkg = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode;
  opencodeWrapper = pkgs.writeShellScriptBin "opencode" ''
    config_dir="''${XDG_CONFIG_HOME:-$HOME/.config}/opencode"
    if [ -f "$config_dir/opencode.local.json" ]; then
      export OPENCODE_CONFIG="$config_dir/opencode.local.json"
    fi
    exec ${opencodePkg}/bin/opencode "$@"
  '';

  opencodeConfig = {
    "$schema" = "https://opencode.ai/config.json";
  };
  ohMyOpenCodeSlimConfig = import ./opencode-slim.nix;
in
{
  options.unixverse.programs.opencode.settings = lib.mkOption {
    type = lib.types.attrs;
    default = { };
  };

  config = {
    xdg.configFile = {
      "opencode/opencode.json".text = json (
        opencodeConfig // config.unixverse.programs.opencode.settings
      );
      "opencode/oh-my-opencode-slim.json".text = json ohMyOpenCodeSlimConfig;
    };

    home.packages = [
      opencodeWrapper
    ];
  };
}
