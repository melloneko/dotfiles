# input-remapper — GUI tool to remap keyboard/mouse buttons and create
# layers/macros. The upstream NixOS module installs the package, the D-Bus
# service, the systemd service and the polkit action.
{ ... }:
{
  flake.modules.nixos.input-remapper = { config, pkgs, lib, ... }: {
    services.input-remapper = {
      enable = true;

      # Upstream disables these by default due to
      # https://github.com/sezanzeb/input-remapper/issues/140
      # Enable if you want presets to auto-load when a device is hotplugged.
      # enableUdevRules = true;

      # The daemon is a system service started with the graphical session.
      # serviceWantedBy = [ "graphical.target" ];
    };

    # --- NixOS-specific pkexec fixes -------------------------------------
    # The GUI starts its privileged "reader service" via
    #   pkexec input-remapper-control --command start-reader-service
    #
    # 1) pkexec in the Nix store is mode 555. NixOS provides a setuid
    #    wrapper in /run/wrappers/bin only when this is enabled.
    #    Without it: "pkexec must be setuid root, code 32512".
    security.polkit.enablePkexecWrapper = true;

    # 2) The upstream action hardcodes /usr/bin/input-remapper-control,
    #    which does not exist here. pkexec canonicalises the program with
    #    realpath() and matches it exactly against the action's
    #    "org.freedesktop.policykit.exec.path" annotation, so install a
    #    copy pointing at the real store path.
    environment.etc."polkit-1/actions/input-remapper.policy".source =
      pkgs.writeText "input-remapper.policy" (
        lib.replaceStrings
          [ "/usr/bin/input-remapper-control" ]
          [ "${config.services.input-remapper.package}/bin/input-remapper-control" ]
          (builtins.readFile "${config.services.input-remapper.package}/share/polkit-1/actions/input-remapper.policy")
      );

    # 3) A bare Hyprland session has no polkit authentication agent, so an
    #    auth_admin prompt would just fail. Allow active local users to run
    #    this one action without a password. (If you later install an agent
    #    such as pkgs.polkit_gnome and want a prompt, remove this rule.)
    security.polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (action.id == "inputremapper" && subject.active && subject.local) {
          return polkit.Result.YES;
        }
      });
    '';
  };
}
