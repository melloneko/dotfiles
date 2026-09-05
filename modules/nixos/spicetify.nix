# flake-parts top-level modules receive `inputs` automatically (mkFlake
# passes it in) — no specialArgs plumbing needed to get it here, and the
# inner NixOS module below can close over it directly.
{ inputs, ... }:
{
  flake.modules.nixos.spicetify = { pkgs, ... }:
    let
      # With flakes:
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
    in
    {
      imports = [ inputs.spicetify-nix.nixosModules.default ];

      programs.spicetify = {
        enable = true;
        enabledExtensions = with spicePkgs.extensions; [
          adblockify
          hidePodcasts
          shuffle # shuffle+ (special characters are sanitized out of extension names)
          beautifulLyrics
          oneko
          songstats
          spicyLyrics
          availabilityMap
        ];
        theme = spicePkgs.themes.matte;
      };
    };
}
