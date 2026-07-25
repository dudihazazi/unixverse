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

  opencodeConfig = {
    "$schema" = "https://opencode.ai/config.json";
    plugin = [
      "oh-my-opencode-slim"
      "./plugins/caveman/plugin.js"
    ];
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
      opencodePkg
    ];
  };
}
