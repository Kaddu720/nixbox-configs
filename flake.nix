{
  description = "Flake for setting up boxes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/0.1";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
    };

    nvim-config = {
      url = "github:Kaddu720/neovim-config?ref=master";
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
  };

  outputs = {
    nixpkgs,
    determinate,
    home-manager,
    darwin,
    ghostty,
    ...
  } @ inputs: {
    # Host Configs
    nixosConfigurations = {
      Home-Box = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/home-box/configuration.nix
          determinate.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
      };
      Mobile-Box = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/mobile-box/configuration.nix
          determinate.nixosModules.default
          inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
          inputs.auto-cpufreq.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
      };
    };
    darwinConfigurations = {
      Work-Box = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/work-box/configuration.nix
          determinate.darwinModules.default
          inputs.nix-homebrew.darwinModules.nix-homebrew
        ];
      };
    };

    # Home-manager Configs
    homeConfigurations = {
      Home-Box = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./hosts/home-box/home-manager.nix
          inputs.nvim-config.homeModules.default
          inputs.stylix.homeManagerModules.stylix
        ];
      };
      Mobile-Box = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./hosts/mobile-box/home-manager.nix
          inputs.nvim-config.homeModules.default
          inputs.stylix.homeManagerModules.stylix
        ];
      };
      Work-Box = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {system = "aarch64-darwin";};
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./hosts/work-box/home-manager.nix
          inputs.stylix.homeManagerModules.stylix
          inputs.nvim-config.homeModules.default
        ];
      };
    };
  };
}
