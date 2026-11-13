{ ... }:
{
  flake.modules.nixos.chinese-input = { pkgs, ... }: {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        # Use the GTK/Qt IM modules instead of the Wayland text-input
        # frontend: this is the most reliable setup for LibreOffice,
        # Electron/Chromium and XWayland apps.
        waylandFrontend = true;
        addons = with pkgs.qt6Packages; [
          fcitx5-chinese-addons
        ];
      };
    };

    # Initial fcitx5 profile. It is only written to /etc/xdg/fcitx5;
    # once you change things with fcitx5-configtool, your changes live
    # in ~/.config/fcitx5 and take precedence over this.
    #
    # "Default Layout" matches the compositor layout (French). Fcitx
    # cannot change Hyprland's XKB layout, so leave Hyprland untouched:
    # pinyin is simply typed with the letters on the French keyboard.
    i18n.inputMethod.fcitx5.settings.inputMethod = {
      GroupOrder."0" = "Default";
      "Groups/0" = {
        Name = "Default";
        "Default Layout" = "fr";
        DefaultIM = "pinyin";
      };
      "Groups/0/Items/0".Name = "keyboard-fr";
      "Groups/0/Items/1".Name = "pinyin";
    };
  };
}
