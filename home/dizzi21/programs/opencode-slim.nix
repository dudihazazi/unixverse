let
  gpt56sol = "openai/gpt-5.6-sol";
  gpt56terra = "openai/gpt-5.6-terra";
  gpt56luna = "openai/gpt-5.6-luna";
  sharedMcps = [
    "*"
    "!context7"
  ];
  librarianMcps = [
    "websearch"
    "context7"
    "grep_app"
  ];
in
{
  "$schema" = "https://unpkg.com/oh-my-opencode-slim/oh-my-opencode-slim.schema.json";
  preset = "daily";
  autoUpdate = false;

  presets = {
    daily = {
      orchestrator = {
        model = "openai/gpt-5.6-terra";
        skills = [ "*" ];
        mcps = [
          "*"
          "!context7"
        ];
      };

      oracle = {
        model = "openai/gpt-5.6-terra";
        variant = "high";
        skills = [ "simplify" ];
        mcps = [ ];
      };

      librarian = {
        model = "openai/gpt-5.6-luna";
        variant = "low";
        skills = [ ];
        mcps = [
          "websearch"
          "context7"
          "grep_app"
        ];
      };

      explorer = {
        model = "openai/gpt-5.6-luna";
        variant = "low";
        skills = [ ];
        mcps = [ ];
      };

      designer = {
        model = "openai/gpt-5.6-terra";
        variant = "medium";
        skills = [ ];
        mcps = [ ];
      };

      fixer = {
        model = "openai/gpt-5.6-luna";
        variant = "low";
        skills = [ ];
        mcps = [ ];
      };
    };
  };
}
