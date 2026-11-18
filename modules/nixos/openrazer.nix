# OpenRazer for the Razer Ornata Chroma.
# The upstream NixOS module handles the kernel driver (matched to
# boot.kernelPackages), udev rules, the "openrazer" group and the user
# openrazer-daemon service — we only need to enable it and add our user.
{ ... }:
{
  flake.modules.nixos.openrazer = { pkgs, ... }: {
    hardware.openrazer = {
      enable = true;
      # Needed to start/interact with openrazer-daemon (added to the
      # "openrazer" group). Re-login after the first rebuild.
      users = [ "shrek" ];

      # Optional tweaks (defaults shown):
      # verboseLogging = false;
      # syncEffectsEnabled = true;
      # devicesOffOnScreensaver = true;
      # keyStatistics = false;
    };

    # GUI front-end to control the Chroma lighting.
    # Alternatives: pkgs.razergenie (Qt), pkgs.razer-cli (CLI).
    environment.systemPackages = with pkgs; [
      polychromatic
    ];
  };
}
