# Vicinae launcher — package, declarative theme overrides, and user service.
# Serpantinum remains the bar; this only replaces its launcher. The launcher's
# theme is generated from Serpantinum's live matugen palette so both keep the
# same wallpaper-driven colours.
{ ... }:
{
  flake.modules.homeManager.vicinae = { config, lib, pkgs, ... }:
    let
      overrideFile = "${config.xdg.configHome}/vicinae/nix.json";

      # Serpantinum rewrites this file whenever the wallpaper or theme changes.
      palettePath = "%h/.local/state/serpantinum/qs_colors.json";

      matugenTheme = pkgs.writeShellApplication {
        name = "vicinae-matugen-theme";
        runtimeInputs = [ pkgs.python3 pkgs.vicinae ];
        text = ''
          exec python3 ${../../config/theme/vicinae/matugen-theme.py} "$@"
        '';
      };
    in
    {
      home.packages = [ pkgs.vicinae ];

      # Keep the palette in an override file instead of settings.json:
      # Vicinae writes its own imperative settings there, and a read-only
      # Home Manager symlink would break that.
      xdg.configFile."vicinae/nix.json".source = ../../config/theme/vicinae/settings.json;

      home.sessionVariables.VICINAE_OVERRIDES = overrideFile;

      # Regenerate the Vicinae theme from Serpantinum's palette.
      systemd.user.services.vicinae-matugen-theme = {
        Unit = {
          Description = "Generate the Vicinae matugen theme from Serpantinum's palette";
        };
        Service = {
          Type = "oneshot";
          ExecStart = lib.getExe matugenTheme;
        };
      };

      # Watch Serpantinum's palette and refresh Vicinae when it changes.
      systemd.user.paths.vicinae-matugen-theme = {
        Unit = {
          Description = "Watch Serpantinum's matugen palette";
          After = [ "graphical-session.target" ];
          PartOf = [ "graphical-session.target" ];
        };
        Path.PathChanged = palettePath;
        Install.WantedBy = [ "graphical-session.target" ];
      };

      systemd.user.services.vicinae = {
        Unit = {
          Description = "Vicinae launcher daemon";
          Documentation = [ "https://docs.vicinae.com" ];
          After = [ "graphical-session.target" ];
          Requires = [ "dbus.socket" ];
          PartOf = [ "graphical-session.target" ];
        };

        Service = {
          Type = "simple";
          # Make sure the theme file exists before the server reads it.
          ExecStartPre = "${lib.getExe matugenTheme} --write-only";
          ExecStart = "${lib.getExe pkgs.vicinae} server --replace";
          # Ask the freshly started server to use the generated theme.
          ExecStartPost = lib.getExe matugenTheme;
          ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
          Environment = [
            "USE_LAYER_SHELL=1"
            "VICINAE_OVERRIDES=${overrideFile}"
          ];
          Restart = "always";
          RestartSec = 60;
          KillMode = "process";
        };

        Install.WantedBy = [ "graphical-session.target" ];
      };

      systemd.user.sessionVariables.VICINAE_OVERRIDES = overrideFile;
    };
}
