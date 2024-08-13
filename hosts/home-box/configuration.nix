{ pkgs, ... }: {
    imports = [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ../../modules/common/users/root/nixos.nix
        ../../modules/common/users/noah/nixos.nix
    ];

    boot = {
        # Set up Grub
        loader = {
            efi.canTouchEfiVariables = true;
            grub = {
                enable = true;
                devices = [ "nodev" ];
                efiSupport = true;
                useOSProber = true;
            };
        };
        # decrypt encrypted partition
        initrd.luks.devices = {
            root = {
            device = "/dev/nvme1n1p2";
            preLVM = true;
            };
        };
        # Set up AMD Graphics Drivers
        initrd.kernelModules = [ "amdgpu" ];
    };

    networking.hostName = "Home-Box"; # Define your hostname.

    # Configure Environment
    environment = {
        # List packages at system level
        systemPackages = with pkgs; [
            mangohud
            protonup
        ];
        sessionVariables = {
            STEAM_EXTRA_COMPAT_TOOLS_PATHS =
                "/home/noah/.steam/root/compatibilityrools.d";
        };
    };

    # Configure Programs
    programs = {
        gamemode.enable = true;
        steam = {
            enable = true;
            gamescopeSession.enable = true;
        };
    };
}
