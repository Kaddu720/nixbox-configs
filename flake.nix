{
    description = "Flake for setting up boxes";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
          url = "github:nix-community/home-manager";
          inputs.nixpkgs.follows = "nixpkgs";
        };

        darwin = {
            url = "github:LnL7/nix-darwin";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nixvim = {
            url = "github:nix-community/nixvim";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        kmonad = {
            url = "git+https://github.com/kmonad/kmonad?submodules=1&dir=nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nixos-hardware.url = "github:NixOS/nixos-hardware/master";

        auto-cpufreq = {
           url = "github:AdnanHodzic/auto-cpufreq";
           inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, darwin, home-manager, auto-cpufreq, nixos-hardware, kmonad, nixvim, ... }@inputs: {

        # Host Configs
        nixosConfigurations = {
            Home-Box = nixpkgs.lib.nixosSystem {
                system = "x86-64-linux";
                specialArgs = { inherit inputs; };
                modules = [ 
                    ./hosts/home-box/configuration.nix 
                ];
            };
            Mobile-Box = nixpkgs.lib.nixosSystem {
                system = "x86-64-linux";
                specialArgs = { inherit inputs; };
                modules = [ 
                    ./hosts/mobile-box/configuration.nix 
                    nixos-hardware.nixosModules.framework-12th-gen-intel
                    auto-cpufreq.nixosModules.default
                    kmonad.nixosModules.default
                ];
            };
        };
        darwinConfigurations = {
            Work-Box = darwin.lib.darwinSystem {
                system = "aarch64-darwin";
                specialArgs = { inherit inputs; };
                modules = [
                    ./hosts/work-box/configuration.nix
                ];
            };
        };

        # Home-manager Configs
        homeConfigurations = {
            Home = home-manager.lib.homeManagerConfiguration {
                pkgs = nixpkgs.legacyPackages."x86_64-linux";

                modules = [ 
                    ./users/home.nix 
                    nixvim.homeManagerModules.nixvim
                ];
            };
            Work = home-manager.lib.homeManagerConfiguration {
                pkgs = import nixpkgs { system = "aarch64-darwin"; };

                modules = [ 
                    ./users/work.nix 
                    nixvim.homeManagerModules.nixvim
                ];
            };
        };
    };
}
