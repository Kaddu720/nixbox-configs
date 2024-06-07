# nixbox-configs

__Install Article__
https://qfpl.io/posts/installing-nixos/

__Install Instructions__
When installing, only encrypt your root drive. Then the swap file will be automatically encrypted by nixos.

__Command to run nix rebuild from this direcotry__
sudo nixos-rebuild switch --flake ~/.config/nixbox/#The-Box

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

## Updating the various systems
Linux: sudo nixos-rebuild switch --flake ./#Home-Box --option eval-cache false

Mac: `nix run nix-darwin -- switch --flake ./#Work-Box --show-trace`
