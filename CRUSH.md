# NixOS Configuration Repository

## Build/Rebuild Commands
- **NixOS rebuild**: `sudo nixos-rebuild switch --flake ./#Home-Box --option eval-cache false`
- **NixOS with nh**: `nh os switch` (or `nh os boot` for next boot, `nh os test` for testing)
- **Darwin rebuild**: `nix run nix-darwin -- switch --flake ./#Work-Box --show-trace`
- **Darwin with nh**: `nh darwin switch -H Work-Box`
- **Home Manager**: `nh home switch` or `home-manager switch --flake ./#noah@Work-Box`
- **Update flake inputs**: `nix flake update`

## Code Style & Conventions
- **Language**: Nix configuration files
- **Formatting**: Use 2-space indentation consistently
- **Imports**: Place at top of file in curly braces: `{ lib, config, pkgs, ... }`
- **Module pattern**: Use `lib.mkEnableOption` for optional modules, `lib.mkIf` for conditional config
- **Naming**: Use kebab-case for file names (e.g., `home-manager.nix`), camelCase for Nix attributes
- **Comments**: Use `# ---------- Section Name ----------` for major sections in configuration files
- **Module structure**: Separate `options` and `config` blocks; use `lib.mkDefault` for overridable defaults

## Architecture
- **hosts/**: Machine-specific configurations (Home-Box, Mobile-Box, Work-Box)
- **modules/**: Reusable modules split by system type (nixos/, darwin/, home-manager/)
  - **core/**: Essential modules enabled by default
  - **optional/**: Opt-in modules enabled per-host
- **users/**: User-specific settings imported by hosts
- **Flake structure**: All configs defined in `flake.nix` with `nixosConfigurations`, `homeConfigurations`, and darwin `packages`

## Testing & Validation
- Test changes without switching: `nh os test` (NixOS) or rebuild with `--dry-run`
- Check flake: `nix flake check`
- Validate syntax: Nix will error on rebuild if syntax is invalid

## Notes
- Always use `inherit inputs;` in `specialArgs` for flake inputs
- Enable lazy trees for faster builds (see README)
- Use `lib.mkDefault` for values that should be overridable by hosts
