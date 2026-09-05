{ ... }:
{
  flake.modules.nixos.networking = {
    networking.hostName = "nixos";
    networking.wireless.enable = true;
    networking.networkmanager.enable = true;

    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    networking.firewall.enable = false;
  };
}
