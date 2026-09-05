{ ... }:
{
  flake.modules.nixos.boot = { pkgs, ... }: {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.kernelParams = [ "asus_wmi.fnlock_default=1" ];
    boot.extraModprobeConfig = ''
      options bluetooth disable_ertm=Y
    '';

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. Leave this at your first install's release.
    system.stateVersion = "26.05";
  };
}
