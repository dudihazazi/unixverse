{
  inputs,
  pkgs,
  ...
}:

let
  json = value: (builtins.toJSON value) + "\n";
  opencodePkg = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode;
  ohMyOpenCodeSlimSrc = inputs.oh-my-opencode-slim;

  opencodeConfig = {
    "$schema" = "https://opencode.ai/config.json";
  };

  ohMyOpenCodeSlimConfig = {
    "$schema" = "https://unpkg.com/oh-my-opencode-slim@latest/oh-my-opencode-slim.schema.json";
    preset = "daily";
    autoUpdate = false;

    presets = {
      daily = {
        orchestrator = {
          model = "openai/gpt-5.5";
          skills = [ "*" ];
          mcps = [
            "*"
            "!context7"
          ];
        };

        oracle = {
          model = "openai/gpt-5.5";
          variant = "high";
          skills = [ "simplify" ];
          mcps = [ ];
        };

        librarian = {
          model = "openai/gpt-5.4-mini";
          variant = "low";
          skills = [ ];
          mcps = [
            "websearch"
            "context7"
            "grep_app"
          ];
        };

        explorer = {
          model = "openai/gpt-5.4-mini-fast";
          variant = "low";
          skills = [ ];
          mcps = [ ];
        };

        designer = {
          model = "openai/gpt-5.4-mini";
          variant = "medium";
          skills = [ ];
          mcps = [ ];
        };

        fixer = {
          model = "openai/gpt-5.4-mini-fast";
          variant = "low";
          skills = [ ];
          mcps = [ ];
        };
      };

      quality = {
        orchestrator = {
          model = "openai/gpt-5.5";
          skills = [ "*" ];
          mcps = [
            "*"
            "!context7"
          ];
        };

        oracle = {
          model = "openai/gpt-5.5";
          variant = "high";
          skills = [ "simplify" ];
          mcps = [ ];
        };

        librarian = {
          model = "openai/gpt-5.4-mini";
          variant = "low";
          skills = [ ];
          mcps = [
            "websearch"
            "context7"
            "grep_app"
          ];
        };

        explorer = {
          model = "openai/gpt-5.4-mini";
          variant = "low";
          skills = [ ];
          mcps = [ ];
        };

        designer = {
          model = "openai/gpt-5.4-mini";
          variant = "medium";
          skills = [ ];
          mcps = [ ];
        };

        fixer = {
          model = "openai/gpt-5.4-mini";
          variant = "low";
          skills = [ ];
          mcps = [ ];
        };
      };
    };
  };
in
{
  xdg.configFile = {
    "opencode/opencode.json".text = json opencodeConfig;
    "opencode/oh-my-opencode-slim.json".text = json ohMyOpenCodeSlimConfig;
    "opencode/plugins/oh-my-opencode-slim".source = ohMyOpenCodeSlimSrc;

    "opencode/skills/simplify".source = ohMyOpenCodeSlimSrc + "/src/skills/simplify";
    "opencode/skills/codemap".source = ohMyOpenCodeSlimSrc + "/src/skills/codemap";
    "opencode/skills/clonedeps".source = ohMyOpenCodeSlimSrc + "/src/skills/clonedeps";
  };

  home.packages = [ opencodePkg ];
}
