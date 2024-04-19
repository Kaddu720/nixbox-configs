{
    description = "Flake for setting up boxes";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

        home-manager = {
          url = "github:nix-community/home-manager";
          inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, ... }@inputs:
        let
            system = "x86_64-linux";

            pkgs = import nixpkgs {
                inherit system;

                config = {
                    allowUnfree = true;
                };
            };
        in 
        {
            nixosConfigurations = {
                Home-Box = nixpkgs.lib.nixosSystem {
                    specialArgs = { inherit inputs; };
                    modules = [ 
                        ./hosts/home-box/configuration.nix 
                        inputs.home-manager.nixosModules.default
                    ];
                };
                Mobile-Box = nixpkgs.lib.nixosSystem {
                    specialArgs = { inherit inputs; };
                    modules = [ 
                        ./hosts/mobile-box/configuration.nix 
                        inputs.home-manager.nixosModules.default
                    ];
                };
            };

        };
}
