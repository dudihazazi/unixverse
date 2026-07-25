# Shared Starship settings: icon-forward, truecolor, Windows Terminal-safe.
{
  "$schema" = "https://starship.rs/config-schema.json";

  add_newline = true;
  format = "$os$username$hostname$directory$git_branch$git_status$c$rust$golang$nodejs$python$nix_shell$conda$time$cmd_duration$line_break$character";

  os = {
    disabled = false;
    format = "[$symbol]($style) ";
    style = "bold #79c0ff";
    symbols = {
      Windows = "";
      Ubuntu = "󰕈";
      Linux = "󰌽";
      Arch = "󰣇";
      Debian = "󰣚";
      Fedora = "󰣛";
      Redhat = "󱄛";
      RedHatEnterprise = "󱄛";
      Alpine = "";
      SUSE = "";
      Manjaro = "";
      Gentoo = "󰣨";
      Mint = "󰣭";
      Macos = "󰀵";
      Android = "";
      Amazon = "";
      AOSC = "";
      Raspbian = "󰐿";
      CentOS = "";
    };
  };

  username = {
    show_always = true;
    style_user = "bold #7ee787";
    style_root = "bold #ff7b72";
    format = "[$user]($style) ";
  };

  hostname = {
    ssh_only = false;
    style = "bold #79c0ff";
    format = "[@$hostname]($style) ";
  };

  directory = {
    style = "bold #d2a8ff";
    truncation_length = 3;
    truncation_symbol = "…/";
    format = "[󰉋 $path]($style) ";
    substitutions = {
      Documents = "󰈙 ";
      Downloads = " ";
      Music = "󰝚 ";
      Pictures = " ";
      Developer = "󰲋 ";
    };
  };

  git_branch = {
    symbol = "";
    style = "bold #f2cc60";
    format = "[$symbol $branch]($style) ";
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

  c = {
    symbol = " ";
    style = "bold #7ee787";
    format = "[$symbol$version]($style) ";
  };

  rust = {
    symbol = "";
    style = "bold #ff7b72";
    format = "[$symbol $version]($style) ";
  };

  golang = {
    symbol = "";
    style = "bold #56d4dd";
    format = "[$symbol $version]($style) ";
  };

  nodejs = {
    symbol = "";
    style = "bold #7ee787";
    format = "[$symbol $version]($style) ";
  };

  python = {
    symbol = "";
    style = "bold #79c0ff";
    format = "[$symbol $version]($style) ";
  };

  nix_shell = {
    symbol = "";
    style = "bold #d2a8ff";
    format = "[$symbol $state]($style) ";
  };

  conda = {
    symbol = "";
    style = "bold #d2a8ff";
    format = "[$symbol $environment]($style) ";
    ignore_base = false;
  };

  time = {
    disabled = false;
    time_format = "%R";
    style = "bold #79c0ff";
    format = "[ $time]($style) ";
  };

  cmd_duration = {
    disabled = false;
    min_time = 2000;
    show_milliseconds = true;
    style = "#f2cc60";
    format = "[ $duration]($style) ";
  };

  line_break.disabled = false;

  character = {
    success_symbol = "[❯](bold #7ee787)";
    error_symbol = "[❯](bold #ff7b72)";
    vimcmd_symbol = "[❮](bold #7ee787)";
  };
}
