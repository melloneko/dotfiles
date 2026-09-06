# Assembly point — same role as modules/hosts/nixos.nix, but for the
# home-manager side. Everything referenced here is a self-contained aspect
# defined elsewhere under modules/home/.
{ config, ... }:
{
  flake.modules.homeManager.shrek = { ... }: {
    imports = [
      config.flake.modules.homeManager.packages
      config.flake.modules.homeManager.serpantinum
      config.flake.modules.homeManager.starship
      config.flake.modules.homeManager.zsh
      config.flake.modules.homeManager.neovim
    ];

    # Home Manager needs a bit of information about you and the paths it
    # should manage.
    home.username = "shrek";
    home.homeDirectory = "/home/shrek";

    # This value determines the Home Manager release that your
    # configuration is compatible with. Don't change it just to match a
    # newer Home Manager — check the release notes first.
    home.stateVersion = "26.05";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
