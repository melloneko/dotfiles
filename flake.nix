{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		serpantinum.url = "github:ilyamiro/serpantinum";
		noctalia-greeter = {
			url = "github:noctalia-dev/noctalia-greeter";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		spicetify-nix.url = "github:Gerg-L/spicetify-nix";
		qylock = {
			url = "github:Darkkal44/qylock";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};
	outputs = inputs@{ self, nixpkgs, serpantinum, home-manager, qylock, ...}: {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			modules = [
				./configuration.nix
				serpantinum.nixosModules.default
				qylock.nixosModules.default
				home-manager.nixosModules.default
				{
				home-manager.useGlobalPkgs = true;
				home-manager.useUserPackages = true;
				home-manager.extraSpecialArgs = { inherit inputs; };
				home-manager.users."shrek" = import ./home.nix;
				}
			];
	 	};
	};
}
