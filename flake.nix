{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		serpantinum.url = "github:ilyamiro/serpantinum";
		noctalia = {
			url = "github:noctalia-dev/noctalia";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		noctalia-greeter = {
			url = "github:noctalia-dev/noctalia-greeter";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		spicetify-nix.url = "github:Gerg-L/spicetify-nix";
	};
	outputs = inputs@{ self, nixpkgs, serpantinum, ...}: {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			modules = [
			./configuration.nix
			serpantinum.nixosModules.default
			];
	 	};
	};
}
