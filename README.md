# nixbox-configs

## Instalation Philsophy

- __Hosts:__ settings specific to a particual machine

- __Modules:__ Contains users and nix packages/modules

    - __Users:__ Configures users settings, imports all nix packages/modules, and is imported by a host
        - Root contains all of the defualt settings for a machine

    - __Darwin, home-manager, nixos:__ Contains all of the packages, modules, and  configurations of their respecitive nix component

    - __Static:__ Static files like wallpapers

__Install Article__
https://qfpl.io/posts/installing-nixos/

__Install Instructions__
__Encryption__
- When installing, only create and encrypt your root drive. Then the swap file will be automatically encrypted by nixos.

__Setting up a computer__
- you'll have  to set up the personal ssh key in the `.ssh/personal` directory

## Updating System Configurations
Linux: `sudo nixos-rebuild switch --flake ./#Home-Box --option eval-cache false`

Mac: `nix run nix-darwin -- switch --flake ./#Work-Box --show-trace`

## Updating home-manager

 `nix run home-manager -- switch --flake ./#FlakeName`

 linux back up : `home-manager switch --flake ./#Home --option eval-cache  false`

## Updating Packages installed
`nix flake update`

## Notes for Apps
__Activate protondb for gaming__
run `protonup`

## Home-Box
__Bios settings__
- CPU
    - 4550 mhz
    - 1.2V
- RAM
    - Set to Auto
    - Activate XMP

