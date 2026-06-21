let
  gpt55 = "openai/gpt-5.5";
  gpt54mini = "openai/gpt-5.4-mini";
  sharedMcps = [
    "*"
    "!context7"
  ];
  librarianMcps = [
    "websearch"
    "context7"
    "grep_app"
  ];
  noMcps = [ ];
in
{
  "$schema" = "https://unpkg.com/oh-my-opencode-slim/oh-my-opencode-slim.schema.json";
  preset = "daily";
  autoUpdate = false;

  presets = {
    daily = {
      orchestrator = {
        model = gpt55;
        skills = [ "*" ];
        mcps = sharedMcps;
      };

      oracle = {
        model = gpt55;
        variant = "high";
        skills = [ "simplify" ];
        mcps = noMcps;
      };

      librarian = {
        model = gpt54mini;
        variant = "low";
        skills = [ ];
        mcps = librarianMcps;
      };

      explorer = {
        model = gpt54mini;
        variant = "low";
        skills = [ ];
        mcps = noMcps;
      };

      designer = {
        model = gpt54mini;
        variant = "medium";
        skills = [ ];
        mcps = noMcps;
      };

      fixer = {
        model = gpt54mini;
        variant = "low";
        skills = [ ];
        mcps = noMcps;
      };
    };

    quality = {
      orchestrator = {
        model = gpt55;
        skills = [ "*" ];
        mcps = sharedMcps;
      };

      oracle = {
        model = gpt55;
        variant = "high";
        skills = [ "simplify" ];
        mcps = noMcps;
      };

      librarian = {
        model = gpt54mini;
        variant = "low";
        skills = [ ];
        mcps = librarianMcps;
      };

      explorer = {
        model = gpt54mini;
        variant = "low";
        skills = [ ];
        mcps = noMcps;
      };

      designer = {
        model = gpt54mini;
        variant = "medium";
        skills = [ ];
        mcps = noMcps;
      };

      fixer = {
        model = gpt54mini;
        variant = "low";
        skills = [ ];
        mcps = noMcps;
      };
    };
  };
}
