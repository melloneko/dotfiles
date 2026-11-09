{ ... }:

{
  flake.modules.nixos.packages = { pkgs, lib, ... }:
  let
    collection-manager = pkgs.writeShellApplication {
      name = "collection-manager";
      runtimeInputs = [ pkgs.wineWow64Packages.stable pkgs.winetricks ];
      text = ''
        export WINEPREFIX="$HOME/.local/share/collection-manager"
        export WINEARCH=win64
        if [ ! -d "$WINEPREFIX/drive_c/windows/Microsoft.NET" ]; then
          winetricks -q dotnet48
        fi
        exec wine "$HOME/Games/CollectionManager/CollectionManager.App.WinForms.exe" "$@"

      '';
    };
  in
  {
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
      mpc
      rmpc

      # Gaming
      quickshell
      steam
      osu-lazer-bin

      # Programmation
      starship
      nwg-look
      temurin-bin-25

      # Utilities
      kdePackages.kdeconnect-kde
      home-manager
      # wget

      # osu! tools
      collection-manager
    ];

    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
      monaspace
      nerd-fonts.jetbrains-mono
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
