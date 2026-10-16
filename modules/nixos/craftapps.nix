# modules/nixos/craftapps.nix
# ArtCraft Crafting Apps (storytold), packaged by olafkfreund/nix-craftapps
{
  flake.modules.nixos.craftapps = {
    # GPU stack the apps need (harmless if already set elsewhere)
    hardware.graphics.enable = true;

    programs.craftapps = {
      enable = true;

      # Set to true to install everything, then disable the ones you don't want
      enableAll = false;

      apps = {
        photocraft.enable  = true;   # Image editing
        vectorcraft.enable = true;   # Vector illustration
        pdfcraft.enable    = true;   # PDF reading and editing

        lightcraft.enable  = false;  # Photo library and raw processing
        effectcraft.enable = false;  # Motion graphics and VFX
        designcraft.enable = false;  # Page layout and publishing
        filmcraft.enable   = true;  # Video editing
        gridcraft.enable   = false;  # Spreadsheets
        soundcraft.enable  = false;  # Audio recording and editing
        cadcraft.enable    = false;  # CAD and drafting
        wordcraft.enable   = false;  # Word processing
        deckcraft.enable   = false;  # Presentations
      };
    };
  };
}
