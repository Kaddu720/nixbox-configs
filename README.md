# nixbox-configs

__Install Article__
https://qfpl.io/posts/installing-nixos/

__Install Instructions__
When installing, only encrypt your root drive. Then the swap file will be automatically encrypted by nixos.

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

