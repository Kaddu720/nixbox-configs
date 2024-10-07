# Nixbox-configs

## Installation Philosophy

- __Hosts:__ settings specific to a particular machine

- __Modules:__ Contains users and nix packages/modules

    - __Users:__ Configures users settings, imports all nix packages/modules, and is imported by a host
        - Root contains all the default settings for a machine

    - __Darwin, home-manager, nixos:__ Contains all the packages, modules, and configurations of their respective nix component

    - __Static:__ Static files like wallpapers

__Install Article__
https://qfpl.io/posts/installing-nixos/

__Install Instructions__
__Encryption__
- When installing, only create and encrypt your root drive. Then the swap file will be automatically encrypted by nixos.

__Setting up a computer__
- you'll have to set up the personal ssh key in the `.ssh/personal` directory

## Updating System Configurations
Linux: `sudo nixos-rebuild switch --flake ./#Home-Box --option eval-cache false`

Mac: `nix run nix-darwin -- switch --flake ./#Work-Box --show-trace`

## Updating home-manager

 `nix run home-manager -- switch --flake ./#FlakeName`

 Linux back up : `home-manager switch --flake ./#Home --option eval-cache  false`

## Updating Packages installed
`nix flake update`

## Notes for Apps
__Activate proton db for gaming__
run `protonup`

## Home-Box
__Bios settings__
- CPU
    - 4550 MHz
    - 1.2V
- RAM
    - Set to Auto
    - Activate XMP

## On Usage

The goal is to have one work space and one application for each functionality. So, each application needs to be able to contain multiple work spaces within itself
- 1 Terminal for work
    - The terminal can then be multiplexed with tmux
- 1 Browser for Documentation or main usage
    - Zen browser supports work spaces for multiple different contexts

I usually assume that I have a second monitor for communication or entertainment. But if I don't, (like on a laptop) communication will get its own workspace

## On Key maps
- Alt: Window Manager level navigation
- Alt + Shift: Window Movement
- Ctl: Application level navigation
- Ctl + Shift: Application level unit movement
