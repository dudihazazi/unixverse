{ pkgs, ... }:

{
  imports = [
    ../../modules/nixos/personal-base.nix
  ];

  networking.hostName = "wsl";

  wsl.enable = true;
  wsl.defaultUser = "dizzi21";
  programs.nix-ld.enable = true;
  services.dbus.enable = true;
  users.users.dizzi21.linger = true;

  # Temporary workaround for https://github.com/nix-community/NixOS-WSL/issues/1074.
  # Remove when upstream fixes headless WSL user D-Bus activation. Until then,
  # skip switch-to-configuration-ng's per-user reload phase, which autolaunches
  # D-Bus via X11 when no user socket is available.
  nixpkgs.overlays = [
    (final: prev: {
      switch-to-configuration-ng = prev.switch-to-configuration-ng.overrideAttrs (old: {
        postPatch = (old.postPatch or "") + ''
                substituteInPlace src/main.rs \
                  --replace-fail '    os::unix::{fs::PermissionsExt, process::CommandExt},' '    os::unix::fs::PermissionsExt,' \
                  --replace-fail '    logind_manager::OrgFreedesktopLogin1Manager,' '    // WSL does not reload user units during configuration switches.' \
                  --replace-fail '    let old_toplevel = Path::new("/run/current-system")' '    let _old_toplevel = Path::new("/run/current-system")' \
                  --replace-fail '    let logind = login1_proxy(&dbus_conn);' '    let _logind = login1_proxy(&dbus_conn);' \
                  --replace-fail '    // Reload user units' '    /* Reload user units' \
                  --replace-fail '    // Restart sysinit-reactivation.target' '    */

          // Restart sysinit-reactivation.target'
        '';
      });
    })
  ];

  # WSL does not expose a real Wi-Fi stack, so avoid starting wpa_supplicant.
  systemd.services.wpa_supplicant.enable = false;
  system.stateVersion = "26.05";
}
