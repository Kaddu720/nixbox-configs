{
    description = "Flake for setting up boxes";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
          url = "github:nix-community/home-manager";
          inputs.nixpkgs.follows = "nixpkgs";
        };

        nixvim = {
            url = "github:nix-community/nixvim";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    };

    outputs = { self, nixpkgs, nixos-hardware, ... }@inputs:
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
                        inputs.nixvim.nixosModules.nixvim
                    ];
                };
                Mobile-Box = nixpkgs.lib.nixosSystem {
                    specialArgs = { inherit inputs; };
                    modules = [ 
                        ./hosts/mobile-box/configuration.nix 
                        inputs.home-manager.nixosModules.default
                        inputs.nixvim.nixosModules.nixvim
                        inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
                    ];
                };
            };

        };
}
