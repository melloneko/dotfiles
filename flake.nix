{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    serpantinum.url = "github:ilyamiro/serpantinum";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    qylock = {
      url = "github:Darkkal44/qylock";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # import-tree recursively imports every .nix file under ./modules as a
  # flake-parts module. No manual "imports = [ ... ]" list to maintain —
  # dropping a new file in ./modules is enough for it to be picked up.
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      inputs.import-tree ./modules
    );
}
