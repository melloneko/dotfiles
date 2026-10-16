{
  flake.modules.nixos.craftapps = {
    hardware.graphics.enable = true;

    programs.craftapps = {
      enable = true;

      enableAll = false;

      apps = {
        photocraft.enable  = true;   # Image editing
        vectorcraft.enable = true;   # Vector illustration
        pdfcraft.enable    = true;   # PDF reading and editing

        lightcraft.enable  = false;  # Photo library and raw processing
        effectcraft.enable = false;  # Motion graphics and VFX
        designcraft.enable = false;  # Page layout and publishing
        filmcraft.enable   = false;  # Video editing
        gridcraft.enable   = false;  # Spreadsheets
        soundcraft.enable  = false;  # Audio recording and editing
        cadcraft.enable    = false;  # CAD and drafting
        wordcraft.enable   = false;  # Word processing
        deckcraft.enable   = false;  # Presentations
            };
          };
        };
      }
    }
  }
}
