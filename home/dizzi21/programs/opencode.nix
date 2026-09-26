{
  inputs,
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

  ohMyOpenCodeSlimConfig = import ./opencode-slim.nix;
in
{
  xdg.configFile = {
    "opencode/opencode.json".text = json {
      "$schema" = "https://opencode.ai/config.json";
      plugin = [ "oh-my-opencode-slim@2.2.25" ];
    };
    "opencode/oh-my-opencode-slim.json".text = json ohMyOpenCodeSlimConfig;
  };

  home.packages = [ opencodeWrapper ];
}
