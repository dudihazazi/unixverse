# Shared Starship settings. ASCII markers keep this reliable in Windows Terminal.
{
  "$schema" = "https://starship.rs/config-schema.json";
  add_newline = false;
  format = "$username$hostname$directory$git_branch$git_status$nodejs$python$rust$golang$nix_shell$cmd_duration$line_break$character";

  username = {
    show_always = true;
    style_user = "bold #7ee787";
    style_root = "bold #ff7b72";
    format = "[$user]($style)";
  };

  hostname = {
    ssh_only = false;
    style = "bold #79c0ff";
    format = "[@$hostname]($style) ";
  };

  directory = {
    style = "bold #d2a8ff";
    truncation_length = 3;
    truncation_symbol = ".../";
    format = "[$path]($style) ";
  };

  git_branch = {
    symbol = "git:";
    style = "bold #f2cc60";
    format = "[$symbol$branch]($style) ";
  };

  git_status = {
    style = "bold #ff7b72";
    conflicted = "=";
    ahead = ">";
    behind = "<";
    diverged = "<>";
    untracked = "?";
    stashed = "$";
    modified = "!";
    staged = "+";
    renamed = ">";
    deleted = "x";
    format = "[$all_status$ahead_behind]($style) ";
  };

  nodejs = {
    style = "#7ee787";
    format = "[node:$version]($style) ";
  };

  python = {
    style = "#79c0ff";
    format = "[py:$version]($style) ";
  };

  rust = {
    style = "#ff7b72";
    format = "[rust:$version]($style) ";
  };

  golang = {
    style = "#56d4dd";
    format = "[go:$version]($style) ";
  };

  nix_shell = {
    style = "#d2a8ff";
    format = "[nix:$state]($style) ";
  };

  cmd_duration = {
    min_time = 2000;
    style = "#f2cc60";
    format = "[took:$duration]($style) ";
  };

  character = {
    success_symbol = "[>](bold #7ee787) ";
    error_symbol = "[>](bold #ff7b72) ";
  };
}
