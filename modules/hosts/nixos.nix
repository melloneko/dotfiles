# The one place that assembles "aspects" into an actual machine.
# Everything referenced here (config.flake.modules.nixos.*) is defined by
# some file under ../nixos/, each of which is a self-contained, single-
# purpose feature — this file just lists which features this host wants.
{ inputs, config, ... }:
{
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      ../../hardware-configuration.nix

      config.flake.modules.nixos.boot
      config.flake.modules.nixos.locale
      config.flake.modules.nixos.networking
      config.flake.modules.nixos.bluetooth
      config.flake.modules.nixos.users
      config.flake.modules.nixos.desktop
      config.flake.modules.nixos.audio
      config.flake.modules.nixos.services
      config.flake.modules.nixos.packages
      config.flake.modules.nixos.spicetify

      inputs.serpantinum.nixosModules.default
      inputs.qylock.nixosModules.default
      inputs.home-manager.nixosModules.default
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.users."shrek" = config.flake.modules.homeManager.shrek;
      }
    ];
  };
}
