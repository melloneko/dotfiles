{ ... }:
{
  flake.modules.nixos.chinese-input = { pkgs, ... }: {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-chinese-addons
          fcitx5-gtk
        ];
      };
    };

    fonts.packages = with pkgs; [
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];
  };
}
