{
  "$schema" = "https://unpkg.com/oh-my-opencode-slim/oh-my-opencode-slim.schema.json";
  preset = "daily";
  autoUpdate = false;

  presets = {
    daily = {
      orchestrator = {
        model = "openai/gpt-6.1-sol";
        variant = "medium";
        skills = [ "*" ];
        mcps = [
          "*"
          "!context7"
        ];
      };

      oracle = {
        model = "openai/gpt-6.1-sol";
        variant = "high";
        skills = [ "simplify" ];
        skills_include_local = true;
        mcps = [ ];
      };

      librarian = {
        model = "openai/gpt-6-luna";
        variant = "low";
        skills = [ ];
        skills_include_local = true;
        mcps = [
          "context7"
          "gh_grep"
        ];
      };

      explorer = {
        model = "openai/gpt-6-luna";
        variant = "low";
        skills = [ ];
        skills_include_local = true;
        mcps = [ ];
      };

      designer = {
        model = "openai/gpt-6.1-sol";
        variant = "medium";
        skills = [ ];
        skills_include_local = true;
        mcps = [ "pencil" ];
      };

      fixer = {
        model = "openai/gpt-6-luna";
        variant = "high";
        skills = [ ];
        skills_include_local = true;
        mcps = [ ];
      };
    };
  };
}
