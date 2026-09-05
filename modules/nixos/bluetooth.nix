{ ... }:
{
  flake.modules.nixos.bluetooth = {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          ControllerMode = "dual";
          JustWorksRepairing = "always";
          Class = "0x000100";
          FastConnectable = true;
        };
        Policy = {
          AutoEnable = true;
        };
      };
    };

    hardware.xpadneo.enable = true; # Xbox controller
    services.blueman.enable = true;
  };
}
