{
  description = "Flake for setting up boxes";

  #Caches for flox package manager
  # nixConfig.extra-substituters = ["https://cache.flox.dev"];
  # nixConfig.extra-trusted-public-keys = [
  #   "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
  # ];

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/0.1";

    darwin.url = "https://flakehub.com/f/nix-darwin/nix-darwin/0";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # flox = {
    #   url = "github:flox/flox/v1.3.16";
    # };

    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };

    nvim-config = {
      url = "github:Kaddu720/neovim-config?ref=master";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    determinate,
    home-manager,
    darwin,
    self,
    ...
  }: {
    # Nixos Host Configs
    nixosConfigurations = {
      Home-Box = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/home-box/configuration.nix
          determinate.nixosModules.default
        ];
      };
      Mobile-Box = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/mobile-box/configuration.nix
          determinate.nixosModules.default
          inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
        ];
      };
    };

    # Nix-Darwin Host Configs
    packages.aarch64-darwin = {
      Work-Box = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/work-box/configuration.nix
          inputs.determinate.darwinModules.default
          {
            determinate-nix.customSettings = {
              lazy-trees = true;
            };
          }
          inputs.nix-homebrew.darwinModules.nix-homebrew
        ];
      };
    };

    # Home-manager Configs
    homeConfigurations = {
      "noah@Home-Box" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/home-box/home-manager.nix
          inputs.nvim-config.homeModules.default
          inputs.stylix.homeModules.stylix
        ];
      };
      "noah@Mobile-Box" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/mobile-box/home-manager.nix
          inputs.nvim-config.homeModules.default
          inputs.stylix.homeModules.stylix
        ];
      };
      "noah@Work-Box" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."aarch64-darwin";
        extraSpecialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/work-box/home-manager.nix
          inputs.nvim-config.homeModules.default
        ];
      };
    };
  };
}
