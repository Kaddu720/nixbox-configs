{ pkgs, ... }: {
    imports = [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ../../modules/nixos/modules.nix
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

    # Enable openGl graphics
    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };

    networking.hostName = "Home-Box"; # Define your hostname.
    # Pick only one of the below networking options.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

    time = {
        # Set your time zone.
        timeZone = "America/Los_Angeles";
    
        # Allow windows to have correct time on dual boot
        hardwareClockInLocalTime = true;
    };


    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    # Enable sound.
    sound.enable = true;


    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.noah = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
        group = "users";
        createHome = true;
        home = "/home/noah";
        uid = 1000;
    };

    # Enable experimental packages
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;


    # Configure Environment
    environment = {
        # List packages at system level
        systemPackages = with pkgs; [
            dislocker
            gnumake
            home-manager
            killall
            gcc13
            mangohud
            protonup
            python3
            python311Packages.pip
            neovim
            wget
            wirelesstools 
        ];
        variables = { 
            EDITOR = "nvim"; 
            HOME = "/home/noah";
        };
        sessionVariables = {
            STEAM_EXTRA_COMPAT_TOOLS_PATHS =
                "/home/noah/.steam/root/compatibilityrools.d";
        };
    };

    #Configure Services
    services = {
        mysql = {
            enable = true;
            package = pkgs.mariadb;
        };

        # Enable users to use system programs
        locate.enable = true;

        # Enable SSH
        openssh.enable = true;
    };

    # Configure Programs
    programs = {
        slock.enable = true;
        dconf.enable = true; #enable gtk desktops
        gamemode.enable = true;
        ssh = {
            startAgent = true;
            askPassword = "";
        };
        steam = {
            enable = true;
            gamescopeSession.enable = true;
        };
    };

    # Copy the NixOS configuration file and link it from the resulting system
    # (/run/current-system/configuration.nix). This is useful in case you
    # accidentally delete configuration.nix.
    # system.copySystemConfiguration = true;

    # Enable automatic garbage collection
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };

    # This option defines the first version of NixOS you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
    #
    # Most users should NEVER change this value after the initial install, for any reason,
    # even if you've upgraded your system to a new NixOS release.
    #
    # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
    # so changing it will NOT upgrade your system.
    #
    # This value being lower than the current NixOS release does NOT mean your system is
    # out of date, out of support, or vulnerable.
    #
    # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    #
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "23.11"; # Did you read the comment?
}
