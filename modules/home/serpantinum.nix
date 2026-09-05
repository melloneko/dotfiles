# Serpantinum desktop shell — user config + systemd service. (The "desktop"
# nixos aspect handles the system prerequisites; this handles your own
# settings.) Bundled with its own module import since it's the one thing
# that provides the `programs.serpantinum` option in the first place —
# keeping the import next to the settings that need it makes this file
# fully self-contained and portable to another home-manager user.
{ inputs, ... }:
{
  flake.modules.homeManager.serpantinum = { ... }: {
    imports = [ inputs.serpantinum.homeManagerModules.default ];

    programs.serpantinum = {
      enable = true;
      systemd.enable = true;

      settings = {
        wallpaperDir = "/home/shrek/Pictures/Wallpapers";

        general = {
          language = "en";
          weatherUnit = "metric";
          weatherInterval = 30;
        };

        bar = {
          position = "top";
          style = "modular";
          width = 40;
          workspaceCount = 10;
          modules = {
            left = [ "workspaces" ];
            center = [ "time" ];
            right = [ "tray" [ "kb" "wifi" "bt" "vol" "bat" ] ];
          };
        };

        theme = {
          fontFamily = "Adwaita Mono";
          borderRadius = 12;
          matugen = true;
        };

        notifications = {
          dnd = false;
          position = "top right";
          sound = true;
        };
      };
    };
  };
}
