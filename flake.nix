{
    description = "A very basic flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };

    outputs = { self, nixpkgs }:
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
                    specialArgs = { inherit system; };
                    modules = [ ./Home-Box/configuration.nix ];
                };
            };

        };
}
