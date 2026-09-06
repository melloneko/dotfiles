{ inputs, ... }:
{
  flake.modules.homeManager.nix-search-tv = { pkgs, ... }: {
    home.packages = [
      inputs.nix-search-tv.packages.${pkgs.system}.default
      ];

    xdg.configFile."television/cable/nixpkgs.toml".text = ''
      [metadata]
      name = "nixpkgs"
      description = "Search Nixpkgs packages"

      [source]
      command = "nix-search-tv print"

      [preview]
      command = "nix-search-tv preview {}"
    '';
  };
}
