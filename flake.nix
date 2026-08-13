{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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
	outputs = inputs@{ self, nixpkgs, ...}: { 
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs; }; 
			modules = [ 
			./configuration.nix
			];
	 	};
	};
}



