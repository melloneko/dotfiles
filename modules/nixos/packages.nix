{ ... }:
{
  flake.modules.nixos.packages = { pkgs, lib, ... }: {
    nixpkgs.config.allowUnfree = true;

    programs.steam.enable = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      # Window Manager
      hyprland
      kdePackages.qtmultimedia
      # Music
      mpv
      mpd
      rmpc
      # Gaming
      quickshell
      steam
      # Programmation
      starship
      nwg-look
      temurin-bin-25
      # Utilities
      kdePackages.kdeconnect-kde
      home-manager
      # wget
    ];

    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
    ];

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      GST_PLUGIN_SYSTEM_PATH_1_0 = with pkgs.gst_all_1; lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" [
        gstreamer
        gst-plugins-base
        gst-plugins-good
        gst-plugins-bad
        gst-plugins-ugly
        gst-libav
      ];
    };
  };
}
