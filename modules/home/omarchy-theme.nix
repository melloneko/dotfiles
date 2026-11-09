# Omarchy's default theme (Tokyo Night) exported to GTK, Qt, and WezTerm.
# The colour definitions live as static files under config/theme/ so they can
# also be applied by hand without a rebuild.
{ ... }:
{
  flake.modules.homeManager.omarchy-theme = { config, pkgs, ... }: {
    # Adwaita in dark mode, recoloured by the Tokyo Night named colours.
    gtk = {
      enable = true;
      colorScheme = "dark";
      font = {
        name = "Fira Code";
        size = 11;
      };
      gtk3.extraCss = builtins.readFile ../../config/theme/gtk-3.0/gtk.css;
      gtk4.extraCss = builtins.readFile ../../config/theme/gtk-4.0/gtk.css;
    };

    # qt6ct's platform theme is selected manually below: Home Manager's
    # qt.platformTheme = "qtct" also installs qt5ct and exports
    # QT_QPA_PLATFORMTHEME=qt5ct.
    qt = {
      enable = true;
      qt6ctSettings = {
        Appearance = {
          style = "Fusion";
          custom_palette = true;
          color_scheme_path = "${config.xdg.configHome}/qt6ct/colors/omarchy.conf";
        };
        Fonts = {
          general = ''"Fira Code,11"'';
          fixed = ''"Fira Code,11"'';
        };
      };
    };

    home.packages = [ pkgs.qt6Packages.qt6ct ];

    xdg.configFile = {
      "qt6ct/colors/omarchy.conf".source = ../../config/theme/qt6ct/colors/omarchy.conf;
      "wezterm/wezterm.lua".source = ../../config/theme/wezterm/wezterm.lua;
      "wezterm/colors/Omarchy.toml".source = ../../config/theme/wezterm/colors/Omarchy.toml;
    };

    home.sessionVariables.QT_QPA_PLATFORMTHEME = "qt6ct";
    systemd.user.sessionVariables.QT_QPA_PLATFORMTHEME = "qt6ct";
  };
}
