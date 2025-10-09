# Nixbox-configs

## Repository Structure

### Top-Level Directories

- **`hosts/`** - Machine-specific configurations
  - `home-box/` - Desktop Linux machine (NixOS)
  - `mobile-box/` - Framework laptop (NixOS)
  - `work-box/` - macOS work machine (nix-darwin)
  - Each host contains:
    - `configuration.nix` - NixOS/darwin system configuration
    - `home-manager.nix` - Home-manager user configuration
    - `hardware-configuration.nix` - Hardware-specific settings

- **`users/`** - User-specific configurations
  - `noah/` - Personal user configurations
    - `home.nix` - Cross-platform home-manager base config
    - `linux.nix` - Linux-specific home-manager config (Wayland, XDG, desktop)
    - `nixos.nix` - NixOS system-level user account config
  - `work/` - Work user configurations
    - `home.nix` - Work-specific home-manager config
    - `nixos.nix` - Work user account config (if needed)

- **`system/`** - System-wide base configurations
  - `base.nix` - Common NixOS system settings (networking, security, packages)

- **`modules/`** - Reusable nix modules and configurations
  - `darwin/` - macOS-specific modules
  - `home-manager/` - Home-manager modules
    - `core/` - Essential user tools (git, tmux, btop, ssh)
    - `optional/` - Optional features (dev tools, shells, terminals)
      - `desktop/` - Desktop environment configs
        - `linux-desktop/` - Linux desktop components (River, Rofi, etc.)
        - `mac-desktop/` - macOS desktop components (Aerospace)
  - `nixos/` - NixOS-specific modules
    - `core/` - Essential system components
    - `optional/` - Optional system features (Docker, games, Kanata)
  - `common/static/` - Static files (wallpapers, themes)

[__Install Article__](https://qfpl.io/posts/installing-nixos/)

__Install Instructions__
__Encryption__
- When installing, only create and encrypt your root drive. Then the swap file will be automatically encrypted by nixos.

__Setting up a computer__
- you'll have to set up the personal ssh key in the `.ssh/personal` directory

__Lazy Trees__
Make sure you set up lazy trees for faster builds : https://determinate.systems/posts/changelog-determinate-nix-352/

## Configuration Philosophy

### Separation of Concerns

1. **Cross-platform vs Platform-specific**
   - `users/noah/home.nix` - Settings that work on both Linux and macOS
   - `users/noah/linux.nix` - Linux-specific desktop settings (Wayland, XDG)
   - Platform-specific packages separated from common packages

2. **User vs System**
   - User configs in `users/` (home-manager, personal preferences)
   - System configs in `system/` (NixOS, system-wide settings)
   - Host-specific overrides in `hosts/`

3. **Personal vs Work**
   - `users/noah/` - Personal configurations
   - `users/work/` - Work-specific configurations
   - Separate SSH keys, git configs, and packages

## Updating System Configurations

### Using nh (Recommended)

**NixOS:**
- Rebuild and switch: `nh os switch`
- Rebuild and switch after boot: `nh os boot`
- Rebuild and test (no persistence): `nh os test`

**Nix Darwin (macOS):**
- `nh darwin switch -H Work-Box`

**Home Manager:**
- Linux: `nh home switch`
- macOS: `nh home switch -c "noah@Work-Box"`

### Manual Commands

**NixOS:**
```bash
sudo nixos-rebuild switch --flake ./#Home-Box
```

**Nix Darwin:**
```bash
nix run nix-darwin -- switch --flake ./#Work-Box
```

**Home Manager:**
```bash
home-manager switch --flake ./#noah@Home-Box
```

### Updating Flake Inputs
```bash
nix flake update
```


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
- If you ever have to reset the CMOS
  Turns out you need ot have the psu plugged in and turne on, with the system power off

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

## External tools
### AWS
 To set your aws profile use ```set -Ux AWS_PROFILE <profile name>```
