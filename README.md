# nixbox-configs

__Install Instructions__
When installing, only encrypt your root drive. Then the swap file will be automatically encrypted by nixos.

__Command to run nix rebuild from this direcotry__
sudo nixos-rebuild switch --flake ~/.config/nixbox/#The-Box

__Getting pywal to work__
Install pywal. Then install `.cache/wal/colors.nix to` `.cache/wal/colors.json`
