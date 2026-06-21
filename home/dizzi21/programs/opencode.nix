{
  inputs,
  pkgs,
  ...
}:

let
  json = value: (builtins.toJSON value) + "\n";
  opencodePkg = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode;
  opencodeScripts = builtins.path {
    path = ./scripts;
    name = "opencode-scripts";
  };
  opencodeAddonsSync = pkgs.writeShellApplication {
    name = "opencode-addons-sync";
    runtimeInputs = with pkgs; [ git coreutils ];
    text = builtins.readFile (opencodeScripts + "/opencode-addons-sync.sh");
  };

  opencodeConfig = {
    "$schema" = "https://opencode.ai/config.json";
    plugin = [
      "oh-my-opencode-slim"
      "./plugins/ponytail.mjs"
      "./plugins/caveman/plugin.js"
    ];
  };
  ohMyOpenCodeSlimConfig = import ./opencode-slim.nix;
in
{
  xdg.configFile = {
    "opencode/opencode.json".text = json opencodeConfig;
    "opencode/oh-my-opencode-slim.json".text = json ohMyOpenCodeSlimConfig;
  };

  home.packages = [
    opencodePkg
    opencodeAddonsSync
  ];
}
