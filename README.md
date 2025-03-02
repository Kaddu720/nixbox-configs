# Nixbox-configs

## Installation Philosophy

- __Hosts:__ settings specific to a particular machine

- __Modules:__ Contains users and nix packages/modules

    - __Users:__ Configures users settings, imports all nix packages/modules, and is imported by a host
        - Root contains all the default settings for a machine

    - __Darwin, home-manager, nixos:__ Contains all the packages, modules, and configurations of their respective nix component

    - __Static:__ Static files like wallpapers

[__Install Article__](https://qfpl.io/posts/installing-nixos/)

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

## Updating nixos with nh helper
rebuild and switch: `nh os switch`
rebuild and switch after boot: `nh os boot`
rebuild and activate but no switch: `nh os test`
rebuild home manager: `nh home switch`

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

## If a Nix install borks grub
1. Boot into ventory nix installer
2. Open a termina
3. Use Gparted to unecncrypt the partion
4. Run `lsblk` to check partion namting
5. Runn commands
    a. `mount /dev/nvme0n1p2/nixos-vg/root /mnt`
    b. 'mount /dev/nvme0n1p1/ /mnt/boot'
6. cd down to the direcotry containg the nix directory
7. `nix-install --flake ./#Home-Box`


## On Key maps
### Alt: Main monitor window manager level navigation
    - Alt + 1 : `dev` work space (Terminal)
    - Alt + 2 : `web` work space (Browser)
    - Alt + n>2 : n work space
### Meta/Win/Cmd : Second monitor window manager level navigation
    - Meta + 1 : `com` work space (Discord, Slack, Outlook)
    - Meta + 2 : `doc` work space (Documentation, Zoom)

### Alt/Meta + Shift: Window Movement
    - Alt/Meta + Shift + n : Move window to workspace n

### Ctl: Application level navigation
### Ctl + Shift: Application level unit movement

### Themeing
To theme zenbrowser: https://github.com/rose-pine/zen-browser/tree/main
To them vesktop: 
    - go to settings -> vencord -> themes -> Online Themes
    - insert the following theme: https://raw.githubusercontent.com/rose-pine/discord/refs/heads/main/rose-pine.theme.css
