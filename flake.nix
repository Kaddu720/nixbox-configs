{
    description = "Flake for setting up boxes";

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
                    modules = [ ./home-box/configuration.nix ];
                };
                Mobile-Box = nixpkgs.lib.nixosSystem {
                    specialArgs = { inherit system; };
                    modules = [ ./mobile-box/configuration.nix ];
                };
            };

        };
}
