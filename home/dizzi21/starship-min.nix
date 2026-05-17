# Starship prompt settings tailored for WSL terminals
{
  "$schema" = "https://starship.rs/config-schema.json";

  # WSL: keep Nerd Font icons, but avoid powerline separators + bg blocks.
  format = "$os$username$hostname$directory$git_branch$git_status$c$rust$golang$nodejs$python$conda$time$cmd_duration$line_break$character";

  add_newline = true;

  os = {
    disabled = false;
    format = "[$symbol]($style) ";
    style = "bold white";
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
    format = "[$user]($style) ";
    style_user = "bold cyan";
    style_root = "bold red";
  };

  hostname = {
    ssh_only = false;
    format = "[@$hostname]($style) ";
    style = "bold cyan";
  };

  directory = {
    format = "[󰉋 $path]($style) ";
    style = "bold blue";
    truncation_length = 3;
    truncation_symbol = "…/";
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
    format = "[$symbol $branch]($style) ";
    style = "bold yellow";
  };

  git_status = {
    format = "[$all_status$ahead_behind]($style) ";
    style = "yellow";
  };

  c = {
    symbol = " ";
    format = "[$symbol$version]($style) ";
    style = "bold green";
  };

  rust = {
    symbol = "";
    format = "[$symbol $version]($style) ";
    style = "bold green";
  };

  golang = {
    symbol = "";
    format = "[$symbol $version]($style) ";
    style = "bold green";
  };

  nodejs = {
    symbol = "";
    format = "[$symbol $version]($style) ";
    style = "bold green";
  };

  python = {
    symbol = "";
    format = "[$symbol $version]($style) ";
    style = "bold green";
  };

  conda = {
    symbol = "";
    format = "[$symbol $environment]($style) ";
    style = "bold magenta";
    ignore_base = false;
  };

  time = {
    disabled = false;
    time_format = "%R";
    format = "[ $time]($style) ";
    style = "bold white";
  };

  cmd_duration = {
    show_milliseconds = true;
    min_time = 1500;
    format = "[ $duration]($style) ";
    style = "dimmed white";
    show_notifications = false;
  };

  line_break = {
    disabled = false;
  };

  character = {
    disabled = false;
    success_symbol = "[❯](bold green)";
    error_symbol = "[❯](bold red)";
    vimcmd_symbol = "[❮](bold green)";
    vimcmd_replace_one_symbol = "[❮](bold yellow)";
    vimcmd_replace_symbol = "[❮](bold yellow)";
    vimcmd_visual_symbol = "[❮](bold yellow)";
  };
}
