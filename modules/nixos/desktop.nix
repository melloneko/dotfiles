{ ... }:
{
  flake.modules.nixos.desktop = { pkgs, ... }: {
    programs.hyprland = {
      enable = true;
      withUWSM = true; # recommended for most users
      xwayland.enable = true;
    };
    programs.kdeconnect.enable = true;

    programs.serpantinum.enable = true;
    programs.qylock = {
      enable = true;
      theme = "pixel-dusk-city";
      sddm.enable = true;
      quickshell.enable = true; # swap for whichever theme you land on
    };

    # services.displayManager.gdm.enable = true;
    # services.displayManager.gdm.wayland = true;
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      # default compositor is "weston", you can optionally change it to kwin
      # wayland.compositor = "kwin";
    };

    services.udisks2.enable = true;
    services.gvfs.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
    };
  };
}
