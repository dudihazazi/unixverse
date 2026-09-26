{
  "$schema" = "https://unpkg.com/oh-my-opencode-slim/oh-my-opencode-slim.schema.json";
  preset = "daily";
  autoUpdate = false;

  presets = {
    daily = {
      orchestrator = {
        model = "openai/gpt-6-sol";
        variant = "medium";
        skills = [ "*" ];
        mcps = [
          "*"
          "!context7"
        ];
      };

      oracle = {
        model = "openai/gpt-6-sol";
        variant = "high";
        skills = [ "simplify" ];
        mcps = [ ];
      };

      librarian = {
        model = "openai/gpt-6-luna";
        variant = "low";
        skills = [ ];
        mcps = [
          "context7"
          "gh_grep"
        ];
      };

      explorer = {
        model = "openai/gpt-6-luna";
        variant = "low";
        skills = [ ];
        mcps = [ ];
      };

      designer = {
        model = "openai/gpt-6-luna";
        variant = "medium";
        skills = [ ];
        mcps = [ ];
      };

      fixer = {
        model = "openai/gpt-6-luna";
        variant = "high";
        skills = [ ];
        mcps = [ ];
      };
    };
  };
}
