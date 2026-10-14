{ ... }:
{
  flake.modules.nixos.users = { pkgs, ... }: {
    users.users."shrek" = {
      isNormalUser = true;
      description = "shrek";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [ ];
    };
    users.defaultUserShell = pkgs.zsh;
    programs.zsh.enable = true;
    system.activationScripts.fixHomePerms = ''
      chmod 711 /home/shrek
    '';
  };
}
